resource "azurerm_postgresql_server" "postgressql_server" {

    name                    = "teva-${var.environment}-${var.Postgresql_Server}"
    location                = azurerm_resource_group.resource_group.location
    resource_group_name     = azurerm_resource_group.resource_group.name
   
 

   # Move this to azure vault
    administrator_login          = var.db_username
    administrator_login_password = var.db_password

    sku_name = "B_Gen5_2"
    version  = "11"
    storage_mb = 640000

    backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
   
}

resource "azurerm_postgresql_database" "postgressql_db" {
   name                = "teva-${var.Postgresql_DB}"
   resource_group_name = azurerm_resource_group.resource_group.name
   server_name         = azurerm_postgresql_server.postgressql_server.name
   charset             = "UTF8"
   collation          = "English_United States.1252"

}