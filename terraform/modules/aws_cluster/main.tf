resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.role_arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids         = var.subnets
    security_group_ids = [aws_security_group.eks_sg_ingress_rule.id]
  }

  access_config {
    authentication_mode = var.auth_mode
  }

  depends_on = [aws_security_group.eks_sg_ingress_rule]
}
