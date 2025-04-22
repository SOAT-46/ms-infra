resource "aws_security_group" "eks_sg_ingress_rule" {
  name   = "security-group-${var.cluster_name}"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow All HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr]
  }

  egress {
    description = "Allow All HTTP traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr]
  }
}
