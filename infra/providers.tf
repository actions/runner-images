# Remove the section that is not needed.

# Azure Cloud/Commericial
terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.54.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "=3.5.1"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "Terraform-rg"
  #   storage_account_name = ""
  #   container_name       = "terraform-state"
  #   key                  = ""
  # }
  backend "local" {
    path = "Dev_CIRunner.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
