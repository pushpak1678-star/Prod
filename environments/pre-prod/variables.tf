variable "environment" {
  type        = string
  default     = "pre-prod"
  description = "Target deployment environment"
}

variable "location" {
  type        = string
  default     = "East US 2"
  description = "Azure region"
}

variable "project_name" {
  type        = string
  default     = "myapp"
  description = "Project prefix for resource naming"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B2s"
  description = "VM SKU size for pre-prod environment"
}

variable "sql_db_sku" {
  type        = string
  default     = "S0"
  description = "SQL Database SKU"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "pre-prod"
    ManagedBy   = "Terraform"
  }
}
