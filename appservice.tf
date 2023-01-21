resource "random_string" "random_webapp_number" {
  length = 6
  special = false
  upper = false
}


resource "azurerm_service_plan" "serviceplan" {
  name                = "app_service_plan_${random_string.random_webapp_number.result}"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  sku_name            = "F1"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "example" {
  name                = "vin_webapp${random_string.random_webapp_number.result}"
  resource_group_name =  azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  service_plan_id     = azurerm_service_plan.serviceplan.id

  site_config {
    
    application_stack {
      current_stack     = "dotnet"
      dotnet_version    =  "v4.0"
      } 
  }

 
}