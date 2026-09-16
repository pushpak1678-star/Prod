variable "key_vault_name" {
  type        = string
  description = "The name of the Azure Key Vault"
}

variable "location" {
  type        = string
  description = "Azure Region for resources"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "object_id" {
  type        = string
  description = "Azure Principal Object ID for Key Vault Access Policy"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to resources"
}
