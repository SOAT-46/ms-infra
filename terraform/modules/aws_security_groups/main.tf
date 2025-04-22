resource "aws_security_group" "database_security_group" {
  name        = "${var.sg_prefix}-${var.sg_name}"
  description = "Security group for the database"

  ingress {
    description = "Allow All access traffic"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow All access traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

