resource "azurerm_resource_group" "myrsg" {
  name     = format("%s-%s", var.rsg, "${terraform.workspace}")
  location = var.location
}

module "packer" {
  source       = "./packer"
  rsg          = azurerm_resource_group.myrsg.name
  tags         = var.tags
  storage_name = var.storage_name
  location     = var.location
}