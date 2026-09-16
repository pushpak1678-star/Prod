variable "frontend_vm_name" {
  type        = string
  description = "Name of Frontend Virtual Machine"
}

variable "backend_vm_name" {
  type        = string
  description = "Name of Backend Virtual Machine"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "frontend_subnet_id" {
  type        = string
  description = "ID of Frontend Subnet"
}

variable "backend_subnet_id" {
  type        = string
  description = "ID of Backend Subnet"
}

variable "frontend_public_ip_id" {
  type        = string
  description = "ID of Public IP for Frontend VM"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B1s"
  description = "VM SKU size (e.g. Standard_B1s, Standard_B2s, Standard_D2s_v5)"
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "VM Admin Username"
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "VM Admin Password fetched from Key Vault Secret"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
