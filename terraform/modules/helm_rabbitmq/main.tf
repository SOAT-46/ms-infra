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
  namespace  = "rabbitmq"
  chart      = "rabbitmq"
  repository = "oci://registry-1.docker.io/bitnamicharts"

  version    = "15.5.3"
  create_namespace = true

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

  set {
    name  = "image.registry"
    value = "docker.io"
  }

  set {
    name  = "image.repository"
    value = "bitnami/rabbitmq"
  }

  set {
    name  = "image.tag"
    value = "3.12.12"
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
