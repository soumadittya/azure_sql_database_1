resource "azurerm_resource_group" "resource_group_1" {
  name     = "rg1"
  location = "West Europe"
}

# resource "azurerm_storage_account" "example" {
#   name                     = "examplesa"
#   resource_group_name      = azurerm_resource_group.resource_group_1.name
#   location                 = azurerm_resource_group.resource_group_1.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

resource "azurerm_mssql_server" "mssql_server_2" {
  name                         = "mssql-server-2"
  resource_group_name          = azurerm_resource_group.resource_group_1.name
  location                     = azurerm_resource_group.resource_group_1.location
  version                      = "12.0"
  administrator_login          = "${var.mssql_server_1_administrator_login}"
  administrator_login_password = "${var.mssql_server_1_administrator_login_password}"
}

resource "azurerm_mssql_database" "mssql_database_1" {
  name           = "mssql-database-1"
  server_id      = azurerm_mssql_server.mssql_server_2.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 1
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false

  tags = {
    foo = "bar"
  }
}
