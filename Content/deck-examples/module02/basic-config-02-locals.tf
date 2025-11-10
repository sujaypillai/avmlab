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

locals {
  prefix   = "rg-demo"
  location = "UK South"
  tags = {
    environment = "Demo"
  }
}

resource "azurerm_resource_group" "example_one" {
  name     = "${local.prefix}-01"
  location = local.location
  tags     = local.tags
}

resource "azurerm_resource_group" "example_two" {
  name     = "${local.prefix}-02"
  location = local.location
  tags     = local.tags
}
