terraform {
  required_version = ">= 1.0"
  required_providers{
    azurerm ={
      source="hashicorp/azurerm"
      version = "2.67.0"
    }
  }
}

provider "azurerm" {
  features{}
}

resource azurerm_resource_group "rgroup" {
  location = var.rg_location
  name = var.rg_name
}

module "vnet" {
  source = "./modules/az_networking"
  rg_location = azurerm_resource_group.rgroup.location
  rg_name = azurerm_resource_group.rgroup.name
  vnet_name = var.vnet_name
}