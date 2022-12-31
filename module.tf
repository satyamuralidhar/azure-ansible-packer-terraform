resource "azurerm_resource_group" "myrsg" {
  name     = format("%s-%s", var.rsg, "${terraform.workspace}")
  location = var.location
}

module "packer" {
  source   = "./packer_infra"
  rsg      = azurerm_resource_group.myrsg.name
  tags     = var.tags
  location = var.location
  depends_on = [
    azurerm_resource_group.myrsg
  ]
}


resource "null_resource" "packer-cmds" {
  provisioner "local-exec" {
    command = "packer build -var-file='../azure.hcl' packer"
  }
  depends_on = [
    azurerm_resource_group.myrsg,
    module.packer
  ]
}


module "virtualmachine" {
  source             = "./virtualmachine"
  rsg                = azurerm_resource_group.myrsg.name
  location           = var.location
  vnet_cidr          = var.vnet_cidr
  nsg_rules          = var.nsg_rules
  subnet_cidr        = var.subnet_cidr
  configuration_file = var.configuration_file
  private_key        = var.private_key
  packerimage        = var.packerimage
  public_key         = var.public_key
  user_name          = var.user_name
  depends_on = [
    azurerm_resource_group.myrsg,
    module.packer,
    null_resource.packer-cmds
  ]
}
