variable "rabbitmq_username" {
  default = "admin"
}

variable "rabbitmq_password" {
  default   = "adminpassword"
  sensitive = true
}

variable "erlang_cookie" {
  default   = "supersecretcookie"
  sensitive = true
}

variable "cluster_name" {
  description = "The cluster name"
  type        = string
}
