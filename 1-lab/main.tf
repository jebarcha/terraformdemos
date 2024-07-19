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
 
resource "azurerm_resource_group" "example"{
  name = "example-resource-group"
  location = "West Europe"
}