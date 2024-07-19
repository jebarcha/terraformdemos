terraform {
  required_version = ">= 1.0"
  required_providers{
    azurerm ={
      source="hashicorp/azurerm"
      version = "3.11.0"
    }
  }
}

provider "azurerm" {
  features{}
}

resource "azurerm_resource_group" "rg_main" {
  location = var.location
  name     = var.rg_name
}

module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"
  resource_group_name = var.rg_name
  vnet_name = var.vnet_name
  address_space = [var.vnet_cdir_range]
  subnet_prefixes = var.subnet_names
  tags = {
    environment = "dev"
  }
  use_for_each  = false
  vnet_location = var.location

  depends_on = [azurerm_resource_group.rg_main]
}

