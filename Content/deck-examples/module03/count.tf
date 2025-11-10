# Good Example
variable "create_resource_group" {
  type    = bool
  default = true
}

variable "resource_group_name" {
  type    = string
  default = "rg-count-eastus2"
}

variable "region" {
  type    = string
  default = "eastus2"
}

resource "azurerm_resource_group" "count" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.region
}

# Bad Example
variable "resource_group_names" {
  type = list(string)
  default = [
    "rg-co-dev",
    "rg-co-test", # What happens if we remove this item from the middle of the list?
    "rg-co-prod"
  ]
}

resource "azurerm_resource_group" "count_bad" {
  count    = length(var.resource_group_names)
  name     = var.resource_group_names[count.index]
  location = var.region
}
