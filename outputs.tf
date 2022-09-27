output "id" {
  description = "The Id of the Linux Virtual Machine."
  value       = var.platform == "windows" ? azurerm_windows_virtual_machine.windows-vm[0].id : azurerm_linux_virtual_machine.linux-vm[0].id
}

output "name" {
  description = "The Id of the Linux Virtual Machine."
  value       = var.platform == "windows" ? azurerm_windows_virtual_machine.windows-vm[0].name : azurerm_linux_virtual_machine.linux-vm[0].name
}


output "identity" {
  description = "An identity block."
  value       = var.platform == "windows" ? azurerm_windows_virtual_machine.windows-vm[0].identity : azurerm_linux_virtual_machine.linux-vm[0].identity
}

output "private_ip_address" {
  description = "The Primary Private IP Address assigned to this Virtual Machine."
  value       = var.platform == "windows" ? azurerm_windows_virtual_machine.windows-vm[0].private_ip_address : azurerm_linux_virtual_machine.linux-vm[0].private_ip_address
}

output "public_ip_address" {
  description = "The Primary Public IP Address assigned to this Virtual Machine."
  value       = var.platform == "windows" ? azurerm_windows_virtual_machine.windows-vm[0].public_ip_address : azurerm_linux_virtual_machine.linux-vm[0].public_ip_address
}

output "virtual_machine_id" {
  description = "A 128-bit identifier which uniquely identifies this Virtual Machine."
  value       = var.platform == "windows" ? azurerm_windows_virtual_machine.windows-vm[0].virtual_machine_id : azurerm_linux_virtual_machine.linux-vm[0].virtual_machine_id
}


