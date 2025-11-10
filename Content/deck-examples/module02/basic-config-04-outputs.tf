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

resource "azurerm_resource_group" "example_two" {
  name     = "${var.prefix}-02"
  location = var.location
  tags     = local.tags
}

output "resource_group_ids" {
  value = {
    example_one = azurerm_resource_group.example_one.id
    example_two = azurerm_resource_group.example_two.id
  }
}
