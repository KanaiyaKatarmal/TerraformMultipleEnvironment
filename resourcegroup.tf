

resource "random_string" "random" {
  length = 6
  special = false
  upper = false
}




# Create a resource group
resource "azurerm_resource_group" "resourcegroup" {
  name     = "${var.rsgname}${random_string.random.result}"
  location = "Central Us"
}
