terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate${replace(lower(var.environment), "-", "")}"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    host                   = module.aks.kube_config.host
    client_certificate     = base64decode(module.aks.kube_config.client_certificate)
    client_key             = base64decode(module.aks.kube_config.client_key)
    cluster_ca_certificate = base64decode(module.aks.kube_config.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = module.aks.kube_config.host
  client_certificate     = base64decode(module.aks.kube_config.client_certificate)
  client_key             = base64decode(module.aks.kube_config.client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_config.cluster_ca_certificate)
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-${var.environment}-rg"
  location = var.location
  tags     = var.tags
}

module "networking" {
  source = "../azure-terraform-modules/modules/networking"

  prefix              = "${var.prefix}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.vnet_address_space
  aks_subnet_cidr     = var.aks_subnet_cidr
  postgres_subnet_cidr = var.postgres_subnet_cidr

  application_security_groups = var.application_security_groups
  application_subnets         = var.application_subnets

  tags = var.tags
}

module "acr" {
  source = "../azure-terraform-modules/modules/acr"

  acr_name           = "${var.prefix}acr${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location           = var.location
  sku                = var.acr_sku
  admin_enabled      = var.acr_admin_enabled
  aks_principal_id   = module.aks.kubelet_identity_object_id
  tags               = var.tags
}

module "aks" {
  source = "../azure-terraform-modules/modules/aks"

  cluster_name         = "${var.prefix}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "${var.prefix}-${var.environment}"
  kubernetes_version  = var.kubernetes_version
  node_count          = var.aks_node_count
  node_vm_size        = var.aks_node_vm_size
  vnet_subnet_id      = module.networking.aks_subnet_id
  tags                = var.tags
}

data "azurerm_client_config" "current" {}

# Create Key Vault for secrets management
module "keyvault" {
  source = "../azure-terraform-modules/modules/keyvault"

  prefix              = var.prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  environment         = var.environment
  tenant_id           = data.azurerm_client_config.current.tenant_id
  aks_identity_object_id = module.aks.kubelet_identity_object_id
  current_user_object_id = data.azurerm_client_config.current.object_id

  secrets = var.keyvault_secrets

  tags = var.tags

  depends_on = [azurerm_resource_group.main]
}

module "postgres" {
  source = "../azure-terraform-modules/modules/postgres"

  server_name          = "${var.prefix}-pgsql-${var.environment}"
  resource_group_name  = azurerm_resource_group.main.name
  location            = var.location
  postgres_version    = var.postgres_version
  administrator_login = var.postgres_admin_login
  use_key_vault              = true
  key_vault_id               = module.keyvault.key_vault_id
  postgres_password_secret_name = "postgres-admin-password"
  storage_mb          = var.postgres_storage_mb
  sku_name            = var.postgres_sku_name
  databases           = var.postgres_databases
  tags                = var.tags

  depends_on = [module.keyvault]
}

module "cosmosdb" {
  source = "../azure-terraform-modules/modules/cosmosdb"

  account_name   = "${var.prefix}-cosmos-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location      = var.location
  offer_type    = var.cosmos_offer_type
  kind          = var.cosmos_kind
  sql_databases = var.cosmos_sql_databases
  tags          = var.tags
}

# ALL applications (infrastructure + business) deployed via single Helm module
module "applications" {
  source = "../azure-terraform-modules/modules/helm"

  applications     = var.applications
  create_namespaces = var.create_namespaces
}