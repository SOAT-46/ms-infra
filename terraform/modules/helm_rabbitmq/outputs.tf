output "rabbitmq_release_name" {
  value = helm_release.rabbitmq.name
}

output "rabbitmq_credentials" {
  value = {
    user     = var.rabbitmq_username
    password = var.rabbitmq_password
  }
  sensitive = true
}

output "rabbitmq_internal_service" {
  value = "${helm_release.rabbitmq.name}-rabbitmq"
}