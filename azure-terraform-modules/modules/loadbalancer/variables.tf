variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "aks_subnet_cidr" {
  description = "AKS subnet CIDR"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "postgres_subnet_cidr" {
  description = "PostgreSQL subnet CIDR"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "aks_default_security_rules" {
  description = "Default security rules for AKS subnet"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  # default = [
  #   {
  #     name                       = "AllowHTTP"
  #     priority                   = 100
  #     direction                  = "Inbound"
  #     access                     = "Allow"
  #     protocol                   = "Tcp"
  #     source_port_range          = "*"
  #     destination_port_range     = "80"
  #     source_address_prefix      = "*"
  #     destination_address_prefix = "*"
  #   },
  #   {
  #     name                       = "AllowHTTPS"
  #     priority                   = 110
  #     direction                  = "Inbound"
  #     access                     = "Allow"
  #     protocol                   = "Tcp"
  #     source_port_range          = "*"
  #     destination_port_range     = "443"
  #     source_address_prefix      = "*"
  #     destination_address_prefix = "*"
  #   },
  #   {
  #     name                       = "AllowSSH"
  #     priority                   = 120
  #     direction                  = "Inbound"
  #     access                     = "Allow"
  #     protocol                   = "Tcp"
  #     source_port_range          = "*"
  #     destination_port_range     = "22"
  #     source_address_prefix      = "VirtualNetwork"
  #     destination_address_prefix = "*"
  #   }
  # ]
}

variable "application_security_groups" {
  description = "Application-specific security groups configuration"
  type = map(object({
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
      description                = optional(string)
    }))
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "application_subnets" {
  description = "Application-specific subnets"
  type = map(object({
    address_prefixes = list(string)
    service_endpoints = optional(list(string), [])
  }))
  default = {}
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}