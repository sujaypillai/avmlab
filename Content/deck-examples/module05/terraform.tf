terraform {
  backend "azurerm" {
    storage_account_name = "<storage account name>"
    container_name       = "<container name>"
    # key                  = "<blob name>"
    use_azuread_auth     = true
  }
}