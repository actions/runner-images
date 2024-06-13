locals {
  prefix    = "community-gallery"
}

data "azurerm_client_config" "current" {}

resource "azurerm_shared_image_gallery" "imageGallery" {
  name                = "azureway_community_gallery"
  resource_group_name = azurerm_resource_group.automation_resource_group.name
  location            = azurerm_resource_group.automation_resource_group.location

  sharing {
    permission = "Community"

    community_gallery {
      eula ="https://github.com/azure-way/actions-runner-images/blob/main/LICENSE" 
      prefix ="azureway"
      publisher_email ="karol@pieciukiewicz.com" 
      publisher_uri ="https://azureway.cloud"
    }
  }  
}

resource "azurerm_resource_group" "automation_resource_group" {
  name     = "rg-${local.prefix}"
  location = var.location
}
