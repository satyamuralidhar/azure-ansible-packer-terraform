locals {
  tags = {
    "Env"          = "${terraform.workspace}",
    "Subscription" = "Development"
  }
}
locals {
  required_tags = {
    Account      = var.tags["Account"]
    Subscription = var.tags["Subscription"]
    Application  = var.tags["Application"]
  }
}


resource "azurerm_storage_account" "mystorage" {
  name                     = lower(var.storage_name)
  resource_group_name      = var.rsg
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.required_tags

}

# resource "null_resource" "packer-cmds" {
#   provisioner "local-exec" {
#     command = "packer build ."
#   }
#   depends_on = [
#     azurerm_storage_account.mystorage
#   ]
# }
