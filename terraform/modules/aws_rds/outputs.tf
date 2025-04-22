output "db_endpoint" {
  description = "The connection endpoint of the RDS instance"
  value       = aws_db_instance.rds_postgres.endpoint
}

output "db_port" {
  description = "The database port"
  value       = aws_db_instance.rds_postgres.port
}
