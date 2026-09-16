terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Network Interface for Frontend VM
resource "azurerm_network_interface" "frontend_nic" {
  name                = "nic-frontend"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.frontend_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.frontend_public_ip_id
  }

  tags = var.tags
}

# Network Interface for Backend VM
resource "azurerm_network_interface" "backend_nic" {
  name                = "nic-backend"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.backend_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

# Frontend Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "frontend_vm" {
  name                            = var.frontend_vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.frontend_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = var.tags

  depends_on = [
    azurerm_network_interface.frontend_nic
  ]
}

# Backend Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "backend_vm" {
  name                            = var.backend_vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.backend_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = var.tags

  depends_on = [
    azurerm_network_interface.backend_nic
  ]
}
resource "azurerm_resource_group" "test-rg" {
  name = test-rg1
  location = "East US"
}