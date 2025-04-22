terraform {
  required_version = ">= 1.9.3"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.35.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.17.0"
    }
  }
}

resource "helm_release" "rabbitmq" {
  name       = "rabbitmq"
  namespace  = "default"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "rabbitmq"
  version    = "12.0.2" # you can check latest via: helm search repo bitnami/rabbitmq

  set {
    name  = "auth.username"
    value = var.rabbitmq_username
  }

  set {
    name  = "auth.password"
    value = var.rabbitmq_password
  }

  set {
    name  = "auth.erlangCookie"
    value = var.erlang_cookie
  }

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  # Optional: Expose via NodePort
  # set {
  #   name  = "service.type"
  #   value = "NodePort"
  # }

  # Optional: enable persistence
  # set {
  #   name  = "persistence.enabled"
  #   value = "true"
  # }
}
