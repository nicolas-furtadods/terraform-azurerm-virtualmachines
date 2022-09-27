# Create Windows VM with windows server
resource "azurerm_windows_virtual_machine" "windows-vm" {
  count               = var.platform == "windows" ? 1 : 0
  depends_on          = [azurerm_network_interface.vm-nic]
  name                = local.windows_machine_name
  computer_name       = local.windows_machine_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password != null ? var.admin_password : random_password.vm-password[0].result
  tags                = var.tags

  network_interface_ids = [azurerm_network_interface.vm-nic.id]

  os_disk {
    name                 = "windows-${random_string.vm-name.result}-disk"
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
}

resource "azurerm_virtual_machine_extension" "custom_data" {
  depends_on           = [azurerm_windows_virtual_machine.windows-vm]
  count                = var.platform == "windows" ? 1 : 0
  name                 = "Post_Configuration"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows-vm[0].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"
  tags                 = var.tags
  settings             = <<SETTINGS
  {
    "commandToExecute": "powershell try { Add-WindowsFeature Web-Server } Catch { Write-Host 'This is a workstation' }"
  }
  SETTINGS
}
