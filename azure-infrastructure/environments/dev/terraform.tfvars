prefix        = "myapp"
location      = "East US"
environment   = "dev"

aks_node_count = 2
aks_node_vm_size = "Standard_B2s"
use_key_vault = true

# postgres_admin_password = ""

tags = {
  Environment = "dev"
  Project     = "bankina"
  Team        = "devops"
}