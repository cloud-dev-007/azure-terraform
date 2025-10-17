output "account_id" {
  description = "The ID of the CosmosDB account"
  value       = azurerm_cosmosdb_account.main.id
}

output "account_name" {
  description = "The name of the CosmosDB account"
  value       = azurerm_cosmosdb_account.main.name
}

output "endpoint" {
  description = "The endpoint of the CosmosDB account"
  value       = azurerm_cosmosdb_account.main.endpoint
}

output "primary_key" {
  description = "The primary key of the CosmosDB account"
  value       = azurerm_cosmosdb_account.main.primary_key
  sensitive   = true
}

output "secondary_key" {
  description = "The secondary key of the CosmosDB account"
  value       = azurerm_cosmosdb_account.main.secondary_key
  sensitive   = true
}

output "primary_master_key" {
  description = "The primary master key of the CosmosDB account"
  value       = azurerm_cosmosdb_account.main.primary_master_key
  sensitive   = true
}

output "secondary_master_key" {
  description = "The secondary master key of the CosmosDB account"
  value       = azurerm_cosmosdb_account.main.secondary_master_key
  sensitive   = true
}

output "connection_strings" {
  description = "A list of connection strings available for this CosmosDB account"
  value       = azurerm_cosmosdb_account.main.connection_strings
  sensitive   = true
}

output "sql_database_ids" {
  description = "The IDs of the created SQL databases"
  value       = { for k, v in azurerm_cosmosdb_sql_database.databases : k => v.id }
}

output "sql_database_names" {
  description = "The names of the created SQL databases"
  value       = { for k, v in azurerm_cosmosdb_sql_database.databases : k => v.name }
}
