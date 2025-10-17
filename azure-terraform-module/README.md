# Azure Terraform Modules

This repository contains reusable Terraform modules for deploying Azure infrastructure.

## Modules

- **aks**: Azure Kubernetes Service cluster
- **networking**: Virtual Network and subnets
- **acr**: Azure Container Registry
- **cosmosdb**: Azure Cosmos DB
- **postgres**: Azure PostgreSQL Flexible Server
- **loadbalancer**: Azure Load Balancer
- **dns**: Azure DNS (public and private zones)
- **helm-release**: Helm chart deployment

## Usage

```hcl
module "aks" {
  source = "git::https://github.com/your-org/azure-terraform-modules.git//modules/aks?ref=v1.0.0"
  
  cluster_name        = "my-aks-cluster"
  location            = "eastus"
  resource_group_name = "my-rg"
  subnet_id           = module.networking.subnet_ids["aks"]
  
  # Additional configuration...
}
```

## Version Requirements

- Terraform >= 1.5.0
- Azure Provider >= 3.0.0

## Contributing

Please read CONTRIBUTING.md for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
```

### CHANGELOG.md
```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-16

### Added
- Initial release with AKS, Networking, ACR, CosmosDB, PostgreSQL, Load Balancer, DNS, and Helm modules
- Support for zone-redundant deployments
- High availability configurations
- Network security groups and firewall rules
- Private endpoints and VNet integration