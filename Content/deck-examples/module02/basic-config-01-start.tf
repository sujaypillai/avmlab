terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example_one" {
  name     = "rg-demo-01"
  location = "UK South"
  tags = {
    environment = "Demo"
  }
}

resource "azurerm_resource_group" "example_two" {
  name     = "rg-demo-02"
  location = "UK South"
  tags = {
    environment = "Demo"
  }
}
