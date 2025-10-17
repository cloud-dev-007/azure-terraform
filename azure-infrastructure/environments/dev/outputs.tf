output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.main.name
}

output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = module.aks.cluster_name
}

output "acr_login_server" {
  description = "ACR login server"
  value       = module.acr.login_server
}

output "postgres_fqdn" {
  description = "PostgreSQL server FQDN"
  value       = module.postgres.fqdn
}

output "cosmosdb_endpoint" {
  description = "CosmosDB endpoint"
  value       = module.cosmosdb.endpoint
}

output "kube_config" {
  description = "Kubernetes config"
  value       = module.aks.kube_config_raw
  sensitive   = true
}

output "kong_service_ip" {
  description = "Kong service IP address"
  value       = module.helm.kong_service_ip
}

output "vnet_id" {
  description = "Virtual Network ID"
  value       = module.networking.vnet_id
}

output "application_nsg_ids" {
  description = "Application NSG IDs"
  value       = module.networking.app_nsg_ids
}

output "application_subnet_ids" {
  description = "Application subnet IDs"
  value       = module.networking.app_subnet_ids
}

output "application_status" {
  description = "Application deployment status"
  value       = module.helm.application_status
}