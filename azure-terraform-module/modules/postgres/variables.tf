variable "server_name" {
  description = "The name of the PostgreSQL Flexible Server"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the PostgreSQL server will be created"
  type        = string
}

variable "postgres_version" {
  description = "The version of PostgreSQL to use"
  type        = string
  default     = "13"
}

variable "administrator_login" {
  description = "The administrator login name for the PostgreSQL server"
  type        = string
  default     = "psqladmin"
}

variable "administrator_password" {
  description = "The administrator password for the PostgreSQL server (only used if use_key_vault is false)"
  type        = string
  sensitive   = true
  default     = null
}

variable "use_key_vault" {
  description = "Whether to use Key Vault for password management"
  type        = bool
  default     = true
}

variable "key_vault_id" {
  description = "Key Vault ID for retrieving password"
  type        = string
  default     = null
}

variable "postgres_password_secret_name" {
  description = "Name of the secret in Key Vault containing the PostgreSQL password"
  type        = string
  default     = "postgres-admin-password"
}

variable "zone" {
  description = "The availability zone for the PostgreSQL server"
  type        = string
  default     = "1"
}

variable "storage_mb" {
  description = "The max storage allowed for the PostgreSQL server in MB"
  type        = number
  default     = 32768
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL server"
  type        = string
  default     = "GP_Standard_D2s_v3"
}

variable "backup_retention_days" {
  description = "Backup retention days for the PostgreSQL server"
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Whether geo-redundant backup is enabled"
  type        = bool
  default     = false
}

variable "databases" {
  description = "List of databases to create"
  type        = list(string)
  default     = ["main"]
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}