resource "azurerm_resource_group" "dynamic" {
  name     = "rg-dynamic"
  location = "West Europe"
}

# Without Dynamic
resource "azurerm_virtual_network" "without_dynamic" {
  name                = "vnet-without-dynamic"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.dynamic.name
  address_space       = ["10.0.0.0/16"]
  subnet {
    name             = "subnet-example"
    address_prefixes = ["10.0.0.0/24"]
  }
  subnet {
    name             = "subnet-example2"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet {
    name             = "subnet-example3"
    address_prefixes = ["10.0.2.0/24"]
  }
}

# With Dynamic
variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = {
    subnet1 = {
      name             = "subnet-example"
      address_prefixes = ["10.0.0.0/24"]
    }
    subnet2 = {
      name             = "subnet-example2"
      address_prefixes = ["10.0.1.0/24"]
    }
    subnet3 = {
      name             = "subnet-example3"
      address_prefixes = ["10.0.2.0/24"]
    }
  }
}
resource "azurerm_virtual_network" "with_dynamic" {
  name                = "vnet-with-dynamic"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.dynamic.name
  address_space       = ["10.0.0.0/16"]
  dynamic "subnet" {
    for_each = var.subnets
    content {
      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
    }
  }
}