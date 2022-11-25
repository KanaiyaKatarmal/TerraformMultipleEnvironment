terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.24.0"
    }
  }

 backend "azurerm" {
    resource_group_name  = "tamopstfstates"
    storage_account_name = "sahelloazuretfkanaiya"
    container_name       = "terraform-state"
    key                  = "dev.terraform.tfstate"
  }
}


resource "random_string" "random" {
  length = 6
  special = false
  upper = false
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  # subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  # tenant_id       = var.tenant_id
}


# Create a resource group
resource "azurerm_resource_group" "resourcegroup" {
  name     = "test${random_string.random.result}"
  location = "Central Us"
}
