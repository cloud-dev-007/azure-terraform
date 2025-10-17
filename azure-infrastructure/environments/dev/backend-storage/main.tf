# backend-setup/main.tf
terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "bankinatfstate"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "bankina-tfstate-dev"
}

resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate"
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${replace(lower(var.environment), "-", "")}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.environment
    purpose     = "terraform-state"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstate.name
}

output "resource_group_name" {
  value = azurerm_resource_group.tfstate.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
}

output "storage_account_connection_string" {
  value = azurerm_storage_account.tfstate.primary_connection_string
}
