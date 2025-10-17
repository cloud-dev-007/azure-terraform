output "vnet_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.main.name
}

output "aks_subnet_id" {
  description = "AKS subnet ID"
  value       = azurerm_subnet.aks.id
}

output "aks_subnet_name" {
  description = "AKS subnet name"
  value       = azurerm_subnet.aks.name
}

output "postgres_subnet_id" {
  description = "PostgreSQL subnet ID"
  value       = azurerm_subnet.postgres.id
}

output "cosmos_subnet_id" {
  description = "CosmosDB subnet ID"
  value       = azurerm_subnet.cosmos.id
}

output "network_security_group_id" {
  description = "Network security group ID"
  value       = azurerm_network_security_group.main.id
}