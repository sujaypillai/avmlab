variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  }))
  default = {
    dev = {
      name     = "rg-fe-dev"
      location = "eastus"
    }
    test = {
      name     = "rg-fe-test"
      location = "westus"
    }
    prod = {
      name     = "rg-fe-prod"
      location = "uksouth"
    }
  }
}

resource "azurerm_resource_group" "for_each" {
  for_each = var.resource_groups
  name     = each.value.name
  location = each.value.location
}
