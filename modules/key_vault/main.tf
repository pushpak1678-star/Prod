terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Generate random password for SQL Server Admin
resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Generate random password for Virtual Machines Admin
resource "random_password" "vm_admin_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Azure Key Vault Resource
resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  tags = var.tags
}

# Key Vault Access Policy for Deployment Identity
resource "azurerm_key_vault_access_policy" "current_user_policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Purge",
    "Recover"
  ]

  depends_on = [
    azurerm_key_vault.kv
  ]
}

# Store SQL Admin Password in Key Vault as Secret
resource "azurerm_key_vault_secret" "sql_admin_password_secret" {
  name         = "sql-admin-password"
  value        = random_password.sql_admin_password.result
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    azurerm_key_vault_access_policy.current_user_policy
  ]
}

# Store VM Admin Password in Key Vault as Secret
resource "azurerm_key_vault_secret" "vm_admin_password_secret" {
  name         = "vm-admin-password"
  value        = random_password.vm_admin_password.result
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    azurerm_key_vault_access_policy.current_user_policy
  ]
}
