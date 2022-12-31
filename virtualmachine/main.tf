# resource "azurerm_resource_group" "myrsg" {
#   name     = format("%s-%s",var.rsg,terraform.workspace)
#   location = var.location
#   tags     = local.tags
# }

resource "azurerm_virtual_network" "myvnet" {
  name                = format("%s-%s-%s-%s", var.rsg, var.location, "vnet",terraform.workspace)
  resource_group_name = var.rsg
  location            = var.location
  address_space       = var.vnet_cidr
  tags                = local.tags
}

resource "azurerm_subnet" "mysubnet" {
  count                = length(var.subnet_cidr)
  name                 = format("%s-%s-%s-%s","subnet",var.location,terraform.workspace,count.index+1)
  virtual_network_name = azurerm_virtual_network.myvnet.name
  resource_group_name  = var.rsg
  address_prefixes     = element([var.subnet_cidr],count.index)
}

resource "azurerm_public_ip" "pip" {
  name                = format("%s-%s", "pip", terraform.workspace)
  location            = azurerm_virtual_network.myvnet.location
  resource_group_name = var.rsg
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "mynic" {
  name                = format("%s-%s", "mynic", terraform.workspace)
  location            = azurerm_virtual_network.myvnet.location
  resource_group_name = var.rsg

  ip_configuration {
    name                          = "mynicip"
    subnet_id                     = azurerm_subnet.mysubnet[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id

  }
}

resource "azurerm_network_security_group" "nsg" {
  resource_group_name = var.rsg
  name                = format("%s-%s", terraform.workspace, "nsg")
  location            = azurerm_virtual_network.myvnet.location
  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }
}

resource "azurerm_network_interface_security_group_association" "nicassociation" {
  network_interface_id      = azurerm_network_interface.mynic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "nsgassociation" {
  subnet_id                 = azurerm_subnet.mysubnet[0].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "myvm" {
  name                  = format("%s-%s-%s", var.rsg, "mylinuxvm", terraform.workspace)
  location              = azurerm_virtual_network.myvnet.location
  resource_group_name   = var.rsg
  size                  = "Standard_B1s"
  admin_username        = var.user_name
  network_interface_ids = [azurerm_network_interface.mynic.id]

  admin_ssh_key {
    username   = var.user_name
    public_key = file(var.public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_image.packerimage.id


  provisioner "remote-exec" {
    inline = [
      "sudo service httpd restart",
      "sudo service httpd status",
      "sudo firewall-cmd --zone=public --add-service=http"
    ]
    connection {
      type        = "ssh"
      user        = var.user_name
      private_key = file(var.private_key)
      host        = azurerm_linux_virtual_machine.myvm.public_ip_address
    }
  }
}