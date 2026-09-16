variable "environment" {
  type        = string
  default     = "production"
  description = "Target deployment environment"
}

variable "location" {
  type        = string
  default     = "West US 2"
  description = "Azure region"
}

variable "project_name" {
  type        = string
  default     = "myapp"
  description = "Project prefix for resource naming"
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2s_v5"
  description = "VM SKU size for production environment"
}

variable "sql_db_sku" {
  type        = string
  default     = "GP_Gen5_2"
  description = "SQL Database SKU"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "production"
    ManagedBy   = "Terraform"
    Criticality = "High"
  }
}
