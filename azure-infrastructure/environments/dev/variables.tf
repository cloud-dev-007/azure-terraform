variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
}

variable "aks_subnet_cidr" {
  description = "AKS subnet CIDR"
  type        = list(string)
}

variable "postgres_subnet_cidr" {
  description = "PostgreSQL subnet CIDR"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}

variable "aks_node_count" {
  description = "Number of AKS nodes"
  type        = number
}

variable "aks_node_vm_size" {
  description = "AKS node VM size"
  type        = string
}

variable "acr_sku" {
  description = "ACR SKU"
  type        = string
}

variable "acr_admin_enabled" {
  description = "ACR admin enabled"
  type        = bool
}

variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string
}

variable "postgres_admin_login" {
  description = "PostgreSQL admin login"
  type        = string
}

variable "postgres_admin_password" {
  description = "PostgreSQL admin password"
  type        = string
  sensitive   = true
}

variable "postgres_storage_mb" {
  description = "PostgreSQL storage in MB"
  type        = number
}

variable "postgres_sku_name" {
  description = "PostgreSQL SKU name"
  type        = string
}

variable "postgres_databases" {
  description = "PostgreSQL databases to create"
  type        = list(string)
}

variable "cosmos_offer_type" {
  description = "CosmosDB offer type"
  type        = string
}

variable "cosmos_kind" {
  description = "CosmosDB kind"
  type        = string
}

variable "cosmos_sql_databases" {
  description = "CosmosDB SQL databases"
  type = map(object({
    throughput = number
  }))
}

# REMOVED Kong-specific variables - applications define their own deployments

variable "infrastructure_applications" {
  description = "Infrastructure-level applications to deploy (like ingress controllers, monitoring, etc.)"
  type = map(object({
    repository       = string
    chart            = string
    version          = string
    namespace        = string
    create_namespace = optional(bool, true)
    timeout          = optional(number, 300)
    values_file      = optional(string)
    values = optional(map(string), {})
    sensitive_values = optional(map(string), {})
    set_lists        = optional(map(list(string)), {})
    namespace_labels = optional(map(string), {})
    namespace_annotations = optional(map(string), {})
  }))
  default = {}
}

variable "create_namespaces" {
  description = "Whether to create namespaces for applications"
  type        = bool
  default     = true
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
  default = {}
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
  default     = {}
}

variable "application_namespaces" {
  description = "Application-specific namespaces"
  type = map(object({
    name = string
    labels = optional(map(string), {})
  }))
  default = {}
}
