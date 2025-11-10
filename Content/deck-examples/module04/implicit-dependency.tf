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

variable "location" {
  type    = string
  default = "UK South"
}

variable "prefix" {
  type    = string
  default = "rg-demo"
}

locals {
  tags = {
    environment = "Demo"
  }
}

resource "azurerm_resource_group" "example_one" {
  name     = "${var.prefix}-01"
  location = var.location
  tags     = local.tags
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-demo"
  resource_group_name = azurerm_resource_group.example_one.name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  tags                = local.tags
}
