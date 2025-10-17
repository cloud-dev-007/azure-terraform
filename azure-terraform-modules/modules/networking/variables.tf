variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "aks_subnet_address_prefix" {
  description = "AKS subnet address prefix"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "db_subnet_address_prefix" {
  description = "Database subnet address prefix"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "cosmos_subnet_address_prefix" {
  description = "CosmosDB subnet address prefix"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {
    # environment = var.environment
    owner       = "DevOps"
    project     = "Bankina"
    # location    = var.location
  }
}

variable "aks_subnet_name" {
  description = "Name of the AKS subnet"
  type        = string
  default     = "aks-subnet"
}

variable "db_subnet_name" {
  description = "Name of the database subnet"
  type        = string
  default     = "db-subnet"
}

variable "cosmos_subnet_name" {
  description = "Name of the CosmosDB subnet"
  type        = string
  default     = "cosmos-subnet"
}
