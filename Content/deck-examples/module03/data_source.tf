# az group create --name rg-data-source-example --location "UK South" --tags Environment=Production

data "azurerm_resource_group" "data_source_example" {
  name = "rg-data-source-example"
}

locals {
  data_source_tags = data.azurerm_resource_group.data_source_example.tags
  # Result: data_source_tags = { "Environment" = "Production" }
}

output "data_source" {
  value = local.data_source_tags
}
