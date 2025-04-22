output "db_endpoint" {
  description = "The connection endpoint of the RDS instance"
  value       = aws_db_instance.rds_postgres.endpoint
}

output "db_port" {
  description = "The database port"
  value       = aws_db_instance.rds_postgres.port
}

output "normal_username" {
  sensitive = true
  description = "The database username"
  value = random_string.normal_username.result
}

output "normal_password" {
  sensitive = true
  description = "The database password"
  value = random_password.normal_password.result
}
