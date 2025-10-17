variable "account_name" {
  description = "The name of the CosmosDB account"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the CosmosDB account will be created"
  type        = string
}

variable "offer_type" {
  description = "The CosmosDB offer type"
  type        = string
  default     = "Standard"
}

variable "kind" {
  description = "The CosmosDB kind"
  type        = string
  default     = "GlobalDocumentDB"
}

variable "enable_automatic_failover" {
  description = "Enable automatic failover for the CosmosDB account"
  type        = bool
  default     = true
}

variable "enable_multiple_write_locations" {
  description = "Enable multiple write locations"
  type        = bool
  default     = false
}

variable "consistency_level" {
  description = "The consistency level of the CosmosDB account"
  type        = string
  default     = "Session"
}

variable "max_interval_in_seconds" {
  description = "The max interval in seconds for consistency"
  type        = number
  default     = 5
}

variable "max_staleness_prefix" {
  description = "The max staleness prefix for consistency"
  type        = number
  default     = 100
}

variable "additional_geo_locations" {
  description = "Additional geo locations for the CosmosDB account"
  type = list(object({
    location          = string
    failover_priority = number
  }))
  default = []
}

variable "sql_databases" {
  description = "Map of SQL databases to create"
  type = map(object({
    throughput = number
  }))
  default = {
    "main" = {
      throughput = 400
    }
  }
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}