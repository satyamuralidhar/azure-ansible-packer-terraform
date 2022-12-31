source "azure-arm" "packer-image" {
  client_id                         = var.client_id
  client_secret                     = var.client_secret
  subscription_id                   = var.subscription_id
  tenant_id                         = var.tenant_id
  os_type                           = "Linux"
  image_publisher                   = "RedHat"
  image_offer                       = "RHEL"
  image_sku                         = "79-gen2"
  location                          = var.location
  vm_size                           = "Standard_B1s"
  managed_image_resource_group_name = var.resource_group_name
  managed_image_name                = var.packer_image_name
}

build {
  sources = [
    "source.azure-arm.packer-image"
  ]
    provisioner "shell" {
    scripts = [
      "scripts/install.sh",
    ]
  }
  provisioner "shell" {
    inline = [
      "sudo yum install java-1.8.0-openjdk-devel -y",
      "sudo yum install httpd -y",
      "sudo firewall-cmd --zone=public --add-service=http",
      "sudo firewall-cmd --reload",
      "sudo service httpd restart",
      "sudo service httpd status",
      "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
    ]
    inline_shebang = "/bin/sh -x"
  }
  
  provisioner "ansible" {
    playbook_file = var.playbook
    roles_path    = "../lamp"
  }

  provisioner "shell" {
    scripts = [
      "scripts/uninstall.sh"
    ]
    inline_shebang = "/bin/sh -x"
  }

}