##########################################################################
# 2. Instances
##########################################################################

# Generate a random vm name
resource "random_string" "vm-name" {
  length  = 7
  upper   = false
  numeric = false
  lower   = true
  special = false
}

# Generate a random password.
resource "random_password" "vm-password" {
  length           = 16
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric          = true
  special          = true
  override_special = "!@#$%&"
}


# Create Network Card for the VM
resource "azurerm_network_interface" "vm-nic" {
  name                = "nic-${local.naming}-001"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}


resource "azurerm_key_vault_secret" "vm-password" {
  depends_on = [
    azurerm_linux_virtual_machine.linux-vm,
    azurerm_windows_virtual_machine.windows-vm
  ]
  name         = var.platform == "windows" ? local.windows_machine_name : local.linux_machine_name
  value        = random_password.vm-password.result
  key_vault_id = var.key_vault_id
}

