variable "rsg" {}
variable "location" {}
variable "tags" {
  type        = map(any)
  description = "adding tags for resources by using local function"
}

variable "vnet_cidr" {}
variable "subnet_cidr" {}

variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "configuration_file" {}
variable "private_key" {}
variable "public_key" {}

variable "packerimage" {
  description = "Enter Packer image Name"
}
variable "user_name" {}