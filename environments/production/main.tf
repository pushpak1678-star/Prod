terraform {
  required_version = ">= 1.0"
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

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

# DATA BLOCK 1: Fetch Current Azure Client/Identity Information
data "azurerm_client_config" "current" {}

# Random string suffix for globally unique resource names
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  tags     = var.tags
}

# 1. NETWORKING MODULE (VNet, Subnets, Public IP, NSGs)
module "networking" {
  source                  = "../../modules/networking"
  vnet_name               = "vnet-${var.project_name}-${var.environment}"
  vnet_address_space      = "10.0.0.0/16"
  frontend_subnet_prefix  = "10.0.1.0/24"
  backend_subnet_prefix   = "10.0.2.0/24"
  frontend_public_ip_name = "pip-frontend-${var.project_name}-${var.environment}"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  tags                    = var.tags

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# 2. KEY VAULT MODULE
module "key_vault" {
  source              = "../../modules/key_vault"
  key_vault_name      = "kv-${var.project_name}-${var.environment}-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
  tags                = var.tags

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# DATA BLOCK 2: Fetch SQL Password Secret from Key Vault
data "azurerm_key_vault_secret" "sql_password_data" {
  name         = module.key_vault.sql_admin_password_secret_name
  key_vault_id = module.key_vault.key_vault_id

  depends_on = [
    module.key_vault
  ]
}

# DATA BLOCK 3: Fetch VM Password Secret from Key Vault
data "azurerm_key_vault_secret" "vm_password_data" {
  name         = module.key_vault.vm_admin_password_secret_name
  key_vault_id = module.key_vault.key_vault_id

  depends_on = [
    module.key_vault
  ]
}

# 3. Azure SQL DATABASE MODULE
module "sql_database" {
  source                 = "../../modules/sql_database"
  sql_server_name        = "sql-${var.project_name}-${var.environment}-${random_string.suffix.result}"
  sql_database_name      = "db-${var.project_name}-${var.environment}"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  administrator_login    = "sqladmin"
  administrator_password = data.azurerm_key_vault_secret.sql_password_data.value
  sku_name               = var.sql_db_sku
  tags                   = var.tags

  depends_on = [
    module.key_vault,
    data.azurerm_key_vault_secret.sql_password_data
  ]
}

# 4. VIRTUAL MACHINES MODULE (Frontend & Backend Linux VMs)
module "virtual_machines" {
  source                = "../../modules/virtual_machines"
  frontend_vm_name      = "vm-fe-${var.project_name}-${var.environment}"
  backend_vm_name       = "vm-be-${var.project_name}-${var.environment}"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  frontend_subnet_id    = module.networking.frontend_subnet_id
  backend_subnet_id     = module.networking.backend_subnet_id
  frontend_public_ip_id = module.networking.frontend_public_ip_id
  vm_size               = var.vm_size
  admin_username        = "azureuser"
  admin_password        = data.azurerm_key_vault_secret.vm_password_data.value
  tags                  = var.tags

  depends_on = [
    module.networking,
    module.key_vault,
    data.azurerm_key_vault_secret.vm_password_data
  ]
}
