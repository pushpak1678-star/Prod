variable "vnet_name" {
  type        = string
  description = "Name of Virtual Network"
}

variable "vnet_address_space" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for Virtual Network"
}

variable "frontend_subnet_prefix" {
  type        = string
  default     = "10.0.1.0/24"
  description = "CIDR block for Frontend Subnet"
}

variable "backend_subnet_prefix" {
  type        = string
  default     = "10.0.2.0/24"
  description = "CIDR block for Backend Subnet"
}

variable "frontend_public_ip_name" {
  type        = string
  description = "Name of Frontend Public IP"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
