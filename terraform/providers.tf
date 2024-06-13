# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.71"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }

  required_version = ">= 1.1.0"

  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription-id
  client_id       = var.spn-client-id
  client_secret   = var.spn-client-secret
  tenant_id       = var.spn-tenant-id
}