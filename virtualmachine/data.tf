data "azurerm_image" "packerimage" {
    name = var.packerimage
    resource_group_name = var.rsg
}