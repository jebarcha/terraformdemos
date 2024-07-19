terraform {
  required_version = ">= 1.0"
  required_providers{
    azurerm ={
      source = "hashicorp/azurerm"
      version = "2.67.0"
    }
  }
}

provider "azurerm"{
  features{}
}

resource "azurerm_resource_group" "rgroup" {
  location = "southcentralus"
  name = "lab01"
}

resource "azurerm_virtual_network" "vnet" {
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.rgroup.location
  name = "virtualNetwork1"
  resource_group_name = azurerm_resource_group.rgroup.name
  subnet {
    address_prefix = "10.0.1.0/24"
    name = "subnet1"
  }
  tags = {
    environment = "Production"
  }
}