variable "sql_server_name" {
  type        = string
  description = "Name of the Azure SQL Server"
}

variable "sql_database_name" {
  type        = string
  description = "Name of the Azure SQL Database"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure Region for resources"
}

variable "administrator_login" {
  type        = string
  default     = "sqladmin"
  description = "SQL Server admin username"
}

variable "administrator_password" {
  type        = string
  sensitive   = true
  description = "SQL Server admin password"
}

variable "sku_name" {
  type        = string
  default     = "Basic"
  description = "SQL Database SKU tier (e.g. Basic, S0, GP_Gen5_2)"
}

variable "max_size_gb" {
  type        = number
  default     = 2
  description = "Maximum database size in GB"
}

variable "zone_redundant" {
  type        = bool
  default     = false
  description = "Enable zone redundancy for SQL Database"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for resources"
}
