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

resource "azurerm_shared_image" "ubuntu_2004" {
  name                = "azureway-u-20.04"
  gallery_name        = azurerm_shared_image_gallery.imageGallery.name
  resource_group_name = azurerm_resource_group.automation_resource_group.name
  location            = azurerm_resource_group.automation_resource_group.location
  os_type             = "Linux"

  identifier {
    publisher = "Azureway"
    offer     = "GitHubActionsRunner_ubuntu-20.04"
    sku       = "Free"
  }
}

resource "azurerm_shared_image" "ubuntu_2204" {
  name                = "azureway-u-22.04"
  gallery_name        = azurerm_shared_image_gallery.imageGallery.name
  resource_group_name = azurerm_resource_group.automation_resource_group.name
  location            = azurerm_resource_group.automation_resource_group.location
  os_type             = "Linux"

  identifier {
    publisher = "Azureway"
    offer     = "GitHubActionsRunner_ubuntu-22.04"
    sku       = "Free"
  }
}

resource "azurerm_shared_image" "ubuntu_2404" {
  name                = "azureway-u-24.04"
  gallery_name        = azurerm_shared_image_gallery.imageGallery.name
  resource_group_name = azurerm_resource_group.automation_resource_group.name
  location            = azurerm_resource_group.automation_resource_group.location
  os_type             = "Linux"

  identifier {
    publisher = "Azureway"
    offer     = "GitHubActionsRunner_ubuntu-24.04"
    sku       = "Free"
  }
}

resource "azurerm_shared_image" "windows_2019" {
  name                = "azureway-w-2019"
  gallery_name        = azurerm_shared_image_gallery.imageGallery.name
  resource_group_name = azurerm_resource_group.automation_resource_group.name
  location            = azurerm_resource_group.automation_resource_group.location
  os_type             = "Windows"

  identifier {
    publisher = "Azureway"
    offer     = "GitHubActionsRunner_windows-2019"
    sku       = "Free"
  }
}

resource "azurerm_shared_image" "windows_2022" {
  name                = "azureway-w-2022"
  gallery_name        = azurerm_shared_image_gallery.imageGallery.name
  resource_group_name = azurerm_resource_group.automation_resource_group.name
  location            = azurerm_resource_group.automation_resource_group.location
  os_type             = "Windows"

  identifier {
    publisher = "Azureway"
    offer     = "GitHubActionsRunner_windows-2022"
    sku       = "Free"
  }
}
