output "resource_group_name" {
  description = "Main resource group name"
  value       = azurerm_resource_group.main.name
}

output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = module.aks.cluster_name
}

output "aks_cluster_id" {
  description = "AKS cluster ID"
  value       = module.aks.cluster_id
}

output "acr_login_server" {
  description = "ACR login server"
  value       = module.acr.login_server
}

output "acr_name" {
  description = "ACR name"
  value       = module.acr.registry_name
}

output "postgres_fqdn" {
  description = "PostgreSQL FQDN"
  value       = module.postgres.fqdn
}

output "cosmosdb_endpoint" {
  description = "Cosmos DB endpoint"
  value       = module.cosmosdb.endpoint
}

output "public_lb_ip" {
  description = "Public load balancer IP"
  value       = module.public_lb.public_ip_addresses
}

output "vnet_id" {
  description = "VNet ID"
  value       = module.networking.vnet_id
}

output "subnet_ids" {
  description = "Subnet IDs"
  value       = module.networking.subnet_ids
}

output "key_vault_name" {
  description = "Key Vault name"
  value       = azurerm_key_vault.main.name
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.main.vault_uri
}

output "dns_name_servers" {
  description = "DNS name servers"
  value       = var.create_dns_zone ? module.dns.name_servers : []
}

output "kubeconfig_command" {
  description = "Command to get kubeconfig"
  value       = "az aks get-credentials --resource-group ${azurerm_resource_group.aks.name} --name ${module.aks.cluster_name}"
}