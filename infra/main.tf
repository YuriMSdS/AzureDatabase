provider "azurerm" {
  features {}
}

variable "db_password" {
  description = "Senha do administrador do banco de dados"
  type = string
  sensitive = true
}
resource "azurerm_resource_group" "main" {
  name     = "main-project-resources"
  location = "Brazil South"
}

resource "azurerm_postgresql_server" "postgre_database" {
  name                = "postgre-db"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  ssl_enforcement_enabled = true

  administrator_login          = "dbadmin"
  administrator_login_password = var.db_password 
  sku_name                     = "GP_Gen5_2"
  storage_mb                   = 5120
  version                      = "11"
  auto_grow_enabled            = true
}

resource "azurerm_postgresql_database" "db1" {
  name                = "database_prod"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_postgresql_server.postgre_database.name
  charset             = "UTF8"
  collation           = "pt_BR.UTF-8" 
}
