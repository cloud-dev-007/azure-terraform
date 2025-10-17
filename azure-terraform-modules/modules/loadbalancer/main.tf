resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  tags = var.tags
}

resource "azurerm_subnet" "aks" {
  name                 = "${var.prefix}-aks-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.aks_subnet_cidr
}

resource "azurerm_subnet" "postgres" {
  name                 = "${var.prefix}-postgres-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.postgres_subnet_cidr

  enforce_private_link_endpoint_network_policies = true
}

# Default NSG for AKS subnet
resource "azurerm_network_security_group" "aks_default" {
  name                = "${var.prefix}-aks-default-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.aks_default_security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = var.tags
}

# Application-specific NSGs
resource "azurerm_network_security_group" "app_nsgs" {
  for_each = var.application_security_groups

  name                = "${var.prefix}-${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
      description                = lookup(security_rule.value, "description", null)
    }
  }

  tags = merge(var.tags, each.value.tags)
}

# Associate NSGs with subnets
resource "azurerm_subnet_network_security_group_association" "aks_default" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.aks_default.id
}

# Create application-specific subnets if needed
resource "azurerm_subnet" "app_subnets" {
  for_each = var.application_subnets

  name                 = "${var.prefix}-${each.key}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = each.value.address_prefixes

  service_endpoints = lookup(each.value, "service_endpoints", [])
}

resource "azurerm_subnet_network_security_group_association" "app_subnets" {
  for_each = var.application_subnets

  subnet_id                 = azurerm_subnet.app_subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.app_nsgs[each.key].id
}