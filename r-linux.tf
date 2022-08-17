data "template_file" "linux-vm-cloud-init" {
  count    = var.platform == "linux" ? 1 : 0
  template = file(local.linux_startup)
}

# Create Linux VM with linux server
resource "azurerm_linux_virtual_machine" "linux-vm" {
  count                           = var.platform == "linux" ? 1 : 0
  depends_on                      = [azurerm_network_interface.vm-nic]
  name                            = local.linux_machine_name
  computer_name                   = local.linux_machine_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = random_password.vm-password.result
  disable_password_authentication = false
  tags                            = var.tags

  network_interface_ids = [azurerm_network_interface.vm-nic.id]

  os_disk {
    name                 = "linux-${random_string.vm-name.result}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    offer     = lookup(var.vm_image, "offer", null)
    publisher = lookup(var.vm_image, "publisher", null)
    sku       = lookup(var.vm_image, "sku", null)
    version   = lookup(var.vm_image, "version", null)
  }
  identity {
    type = "SystemAssigned"
  }
  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  custom_data = base64encode(data.template_file.linux-vm-cloud-init[0].rendered)
}
