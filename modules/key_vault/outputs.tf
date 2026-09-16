output "key_vault_id" {
  value       = azurerm_key_vault.kv.id
  description = "Resource ID of Key Vault"
}

output "key_vault_name" {
  value       = azurerm_key_vault.kv.name
  description = "Name of the Key Vault"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.kv.vault_uri
  description = "Vault URI of the Key Vault"
}

output "sql_admin_password_secret_name" {
  value       = azurerm_key_vault_secret.sql_admin_password_secret.name
  description = "Secret name for SQL Admin password"
}

output "vm_admin_password_secret_name" {
  value       = azurerm_key_vault_secret.vm_admin_password_secret.name
  description = "Secret name for VM Admin password"
}
