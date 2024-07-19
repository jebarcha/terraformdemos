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

resource "random_integer" "rn" {
  max = 99999
  min = 10000
}

resource "azurerm_resource_group" "demo05" {
  location = var.location
  name     = var.rg_name
}

resource "azurerm_storage_account" "sa" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = var.location
  name                     = "${lower(var.naming_prefix)}${random_integer.rn.result}"
  resource_group_name      = azurerm_resource_group.demo05.name
}

resource "azurerm_storage_container" "container" {
  name                 = "terraform-state"
  storage_account_name = azurerm_storage_account.sa.name
}

data "azurerm_storage_account_sas" "sas"{
  connection_string = azurerm_storage_account.sa.primary_connection_string
  https_only = true
  expiry            = timeadd(timestamp(), "17000h")
  start             = timestamp()
  permissions {
    read = true
    write = true
    delete = true
    list = true
    add = true
    create = true
    update = false
    process = false
  }
  resource_types {
    container = true
    object    = true
    service   = true
  }
  services {
    blob = true
    queue = false
    table = false
    file  = false
  }
}

resource "local_file" "post-config" {
  depends_on = [azurerm_storage_container.container]

  filename = "${path.module}/backend-config.txt"
  content = <<EOF
storage_account_name = "${azurerm_storage_account.sa.name}"
container_name = "terraform-state"
key = "terraform.tfstate"
sas_token = "${data.azurerm_storage_account_sas.sas.sas}"

EOF
}