output "ingress_controller_service" {
  value = helm_release.default.status
}
