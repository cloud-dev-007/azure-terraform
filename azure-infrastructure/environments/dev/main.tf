module "infrastructure" {
  source = "../.."

  prefix        = var.prefix
  location      = var.location
  environment   = var.environment

  vnet_address_space = var.vnet_address_space
  aks_subnet_cidr    = var.aks_subnet_cidr
  postgres_subnet_cidr = var.postgres_subnet_cidr

  kubernetes_version = var.kubernetes_version
  aks_node_count     = var.aks_node_count
  aks_node_vm_size   = var.aks_node_vm_size

  acr_sku          = var.acr_sku
  acr_admin_enabled = var.acr_admin_enabled

  postgres_version      = var.postgres_version
  postgres_admin_login  = var.postgres_admin_login
  postgres_admin_password = var.postgres_admin_password
  postgres_storage_mb   = var.postgres_storage_mb
  postgres_sku_name     = var.postgres_sku_name
  postgres_databases    = var.postgres_databases

  cosmos_offer_type   = var.cosmos_offer_type
  cosmos_kind         = var.cosmos_kind
  cosmos_sql_databases = var.cosmos_sql_databases

  deploy_kong      = var.deploy_kong
  kong_values      = var.kong_values

  helm_applications = var.helm_applications

  application_security_groups = var.application_security_groups
  application_subnets         = var.application_subnets

  tags = var.tags
}