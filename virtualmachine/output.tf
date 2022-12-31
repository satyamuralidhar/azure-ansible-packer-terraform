output "public_ip" {
  value = azurerm_linux_virtual_machine.myvm.public_ip_address
}
output "vm_resource_id" {
  value = azurerm_linux_virtual_machine.myvm.id
}