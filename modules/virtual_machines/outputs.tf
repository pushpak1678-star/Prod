output "frontend_vm_id" {
  value       = azurerm_linux_virtual_machine.frontend_vm.id
  description = "ID of Frontend Virtual Machine"
}

output "frontend_vm_private_ip" {
  value       = azurerm_network_interface.frontend_nic.private_ip_address
  description = "Private IP of Frontend VM"
}

output "backend_vm_id" {
  value       = azurerm_linux_virtual_machine.backend_vm.id
  description = "ID of Backend Virtual Machine"
}

output "backend_vm_private_ip" {
  value       = azurerm_network_interface.backend_nic.private_ip_address
  description = "Private IP of Backend VM"
}
