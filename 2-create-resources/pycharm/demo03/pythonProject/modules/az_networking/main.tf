

resource "azurerm_virtual_network" "vnet" {
  address_space = ["10.0.0.0/16"]
  location = var.rg_location
  name = var.vnet_name
  resource_group_name = var.rg_name
  tags = {
    environment = "Production"
  }
}