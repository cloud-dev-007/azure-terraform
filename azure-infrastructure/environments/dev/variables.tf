variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "bankina"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "aks_subnet_cidr" {
  description = "AKS subnet CIDR"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "postgres_subnet_cidr" {
  description = "PostgreSQL subnet CIDR"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.27"
}

variable "aks_node_count" {
  description = "Number of AKS nodes"
  type        = number
  default     = 3
}

variable "aks_node_vm_size" {
  description = "AKS node VM size"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "acr_sku" {
  description = "ACR SKU"
  type        = string
  default     = "Basic"
}

variable "acr_admin_enabled" {
  description = "ACR admin enabled"
  type        = bool
  default     = false
}

variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "13"
}

variable "postgres_admin_login" {
  description = "PostgreSQL admin login"
  type        = string
  default     = "bankinaadmin"
}

variable "postgres_admin_password" {
  description = "PostgreSQL admin password"
  type        = string
  sensitive   = true
  default     = "ChangeMe123!"
}

variable "postgres_storage_mb" {
  description = "PostgreSQL storage in MB"
  type        = number
  default     = 32768
}

variable "postgres_sku_name" {
  description = "PostgreSQL SKU name"
  type        = string
  default     = "GP_Standard_D2s_v3"
}

variable "postgres_databases" {
  description = "PostgreSQL databases to create"
  type        = list(string)
  default     = ["main", "appdb"]
}

variable "cosmos_offer_type" {
  description = "CosmosDB offer type"
  type        = string
  default     = "Standard"
}

variable "cosmos_kind" {
  description = "CosmosDB kind"
  type        = string
  default     = "GlobalDocumentDB"
}

variable "cosmos_sql_databases" {
  description = "CosmosDB SQL databases"
  type = map(object({
    throughput = number
  }))
  default = {
    "bankina" = {
      throughput = 400
    }
  }
}

variable "keyvault_secrets" {
  description = "Secrets to store in Key Vault"
  type        = map(string)
  sensitive   = true
  default = {
    "bankina-admin-password" = "ChangeMe123!"
    "bankina-cosmos-key"    = "bankina-cosmos-key"
    "bankina-jwt-secret"    = "jwt-secret-key-123"
  }
}

variable "application_security_groups" {
  description = "Application-specific security groups"
  type = map(object({
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
      description                = optional(string)
    }))
    tags = optional(map(string), {})
  }))
  default = {
    "webapp" = {
      security_rules = [
        {
          name                       = "AllowHTTP"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
          description                = "Allow HTTP traffic"
        }
      ]
    }
  }
}

variable "application_subnets" {
  description = "Application-specific subnets"
  type = map(object({
    address_prefixes = list(string)
    service_endpoints = optional(list(string), [])
  }))
  default = {}
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "bankina"
    Team        = "devops"
  }
}