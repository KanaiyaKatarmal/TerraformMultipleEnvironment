resource "random_string" "randomdabanumber" {
  length = 6
  special = false
  upper = false
}


resource "azurerm_mssql_server" "mssqlserver" {
  name                         = "mssqlservervim${random_string.randomdabanumber.result}"
  resource_group_name          = azurerm_resource_group.resourcegroup.name
  location                     = azurerm_resource_group.resourcegroup.location
  version                      = "12.0"
  administrator_login          = "${var.mssqlusername}"
  administrator_login_password = "${var.mssqlpassword}"
  minimum_tls_version          = "1.2"
   depends_on = [
     azurerm_resource_group.resourcegroup
   ]
}

resource "azurerm_mssql_database" "mssqldatabase" {
  name           = "vimdatabase"
  server_id      = azurerm_mssql_server.mssqlserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 250
  sku_name       = "S0"
  
  depends_on = [
     azurerm_mssql_server.mssqlserver
   ]
}

resource "azurerm_mssql_firewall_rule" "FirewallRule1" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.mssqlserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
  
  depends_on = [
     azurerm_mssql_server.mssqlserver
   ]
}