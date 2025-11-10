terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.2"
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "core"
}
