variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "namespace" {
  type = string
  validation {
    condition     = length(var.namespace) > 0
    error_message = "The namespace must not be empty."
  }
  description = "The NGINX namespace"
}
