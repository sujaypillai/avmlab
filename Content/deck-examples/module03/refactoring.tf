# Import
# az group create --name rg-created-via-cli --location "UK South"

resource "azurerm_resource_group" "created_via_cli" {
  name     = "rg-created-via-cli"
  location = "UK South"
}

data "azurerm_client_config" "current" {}

import {
  to = azurerm_resource_group.created_via_cli
  id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/rg-created-via-cli"
}

# Moved
/* 
resource "azurerm_resource_group" "before_moved" {
  name     = "rg-moved-example"
  location = "UK South"
}
*/

resource "azurerm_resource_group" "after_moved" {
  name     = "rg-moved-example"
  location = "UK South"
}

moved {
  from = azurerm_resource_group.before_moved
  to   = azurerm_resource_group.after_moved
}

# Removed
/*
resource "azurerm_resource_group" "removed" {
  name     = "rg-removed-example"
  location = "UK South"
}
*/

removed {
  from = azurerm_resource_group.removed
  lifecycle {
    destroy = false
  }
}
