# ref: https://learn.microsoft.com/en-us/azure/container-instances/container-instances-quickstart-terraform
locals {
  image          = "mcr.microsoft.com/azuredocs/aci-helloworld"
  cpu_cores      = 1
  memory_in_gb   = 1
  restart_policy = "OnFailure"
  port           = 80
}

resource "random_string" "container_name" {
  length  = 16
  lower   = true
  upper   = false
  special = false
}

resource "azurerm_container_group" "linux_container" {
  name                = "acigroup-linux-${random_string.container_name.result}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = local.restart_policy

  container {
    name   = "aci-linux-${random_string.container_name.result}"
    image  = local.image
    cpu    = local.cpu_cores
    memory = local.memory_in_gb

    ports {
      port     = local.port
      protocol = "TCP"
    }
  }

  tags = local.tags
}
