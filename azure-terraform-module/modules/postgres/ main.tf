data "azurerm_key_vault_secret" "postgres_password" {
  count = var.use_key_vault ? 1 : 0

  name         = var.postgres_password_secret_name
  key_vault_id = var.key_vault_id
}

resource "azurerm_postgresql_flexible_server" "main" {
  name                   = var.server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.postgres_version
  administrator_login    = var.administrator_login
  administrator_password = var.use_key_vault ? data.azurerm_key_vault_secret.postgres_password[0].value : var.administrator_password
  zone                   = var.zone

  storage_mb = var.storage_mb
  sku_name   = var.sku_name

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "databases" {
  for_each = toset(var.databases)

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.main.id
  charset   = "UTF8"
  collation = "en_US.UTF8"
}