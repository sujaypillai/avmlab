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

module "example" {
  source   = "./modules/demo"
  name     = "${var.prefix}-01"
  location = var.location
}
