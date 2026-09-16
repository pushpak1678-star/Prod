output "sql_server_id" {
  value       = azurerm_mssql_server.sql_server.id
  description = "ID of Azure SQL Server"
}

output "sql_server_fqdn" {
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
  description = "Fully Qualified Domain Name of Azure SQL Server"
}

output "sql_database_name" {
  value       = azurerm_mssql_database.db.name
  description = "Name of Azure SQL Database"
}
