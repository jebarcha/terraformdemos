variable "rg_name" {
  type = string
}

variable "location" {
  type = string
  default = "westus"
}

variable "vnet_name" {
  type = string
}

variable "vnet_cdir_range" {
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_preixes" {
  type = list(string)
  default = ["10.0.0.0/24","10.0.1.0/24"]
}

variable "subnet_names" {
  type = list(string)
  default = ["web","database"]
}