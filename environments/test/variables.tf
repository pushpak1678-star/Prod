variable "environment" {
  type        = string
  default     = "test"
  description = "Target deployment environment"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Azure region"
}

variable "project_name" {
  type        = string
  default     = "myapp"
  description = "Project prefix for resource naming"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B1s"
  description = "VM SKU size for test environment"
}

variable "sql_db_sku" {
  type        = string
  default     = "Basic"
  description = "SQL Database SKU"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "test"
    ManagedBy   = "Terraform"
  }
}
