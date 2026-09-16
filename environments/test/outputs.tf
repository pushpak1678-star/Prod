output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Resource Group Name"
}

output "key_vault_name" {
  value       = module.key_vault.key_vault_name
  description = "Azure Key Vault Name"
}

output "sql_server_fqdn" {
  value       = module.sql_database.sql_server_fqdn
  description = "Azure SQL Server FQDN"
}

output "frontend_vm_id" {
  value       = module.virtual_machines.frontend_vm_id
  description = "Frontend Virtual Machine ID"
}

output "frontend_vm_private_ip" {
  value       = module.virtual_machines.frontend_vm_private_ip
  description = "Frontend VM Private IP"
}

output "backend_vm_id" {
  value       = module.virtual_machines.backend_vm_id
  description = "Backend Virtual Machine ID"
}

output "backend_vm_private_ip" {
  value       = module.virtual_machines.backend_vm_private_ip
  description = "Backend VM Private IP"
}
