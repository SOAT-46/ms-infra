terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.95.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }
  }
}

resource "random_string" "normal_username" {
  length  = 12
  upper   = false
  special = false
}

resource "random_password" "normal_password" {
  length           = 32
  special          = true
  override_special = "_-=+."
}

resource "aws_db_instance" "rds_postgres" {
  publicly_accessible  = true

  identifier = var.database_name

  allocated_storage = var.allocated_storage
  engine            = var.database_engine
  engine_version    = var.database_engine_version
  instance_class    = var.database_instance_class

  username            = random_string.normal_username.result
  password            = random_password.normal_password.result

  port                = var.database_port
  skip_final_snapshot = var.skip_final_snapshot

  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    Name = "MsPostgres"
  }
}
