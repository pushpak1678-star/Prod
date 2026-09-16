output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "ID of Virtual Network"
}

output "frontend_subnet_id" {
  value       = azurerm_subnet.frontend_subnet.id
  description = "ID of Frontend Subnet"
}

output "backend_subnet_id" {
  value       = azurerm_subnet.backend_subnet.id
  description = "ID of Backend Subnet"
}

output "frontend_public_ip_id" {
  value       = azurerm_public_ip.frontend_pip.id
  description = "ID of Frontend Public IP"
}
