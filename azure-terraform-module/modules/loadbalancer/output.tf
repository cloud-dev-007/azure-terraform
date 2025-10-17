output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.main.id
}

output "aks_subnet_id" {
  description = "AKS subnet ID"
  value       = azurerm_subnet.aks.id
}

output "postgres_subnet_id" {
  description = "PostgreSQL subnet ID"
  value       = azurerm_subnet.postgres.id
}

output "app_subnet_ids" {
  description = "Application-specific subnet IDs"
  value       = { for k, v in azurerm_subnet.app_subnets : k => v.id }
}

output "app_nsg_ids" {
  description = "Application-specific NSG IDs"
  value       = { for k, v in azurerm_network_security_group.app_nsgs : k => v.id }
}

output "default_nsg_id" {
  description = "Default NSG ID"
  value       = azurerm_network_security_group.aks_default.id
}