terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }
  }
}

resource "random_uuid" "normal_username" {}

resource "random_uuid" "normal_password" {
  length           = 32
  special          = true
  override_special = "_-=+."
}

resource "aws_db_instance" "rds_postgres" {
  parameter_group_name = "default.postgres15"
  publicly_accessible  = true

  identifier = var.identifier

  allocated_storage = var.allocated_storage
  engine            = var.database_engine
  engine_version    = var.database_engine_version
  instance_class    = var.database_instance_class

  name                = var.database_name
  username            = random_uuid.normal_username
  password            = random_uuid.normal_password
  port                = var.database_port
  skip_final_snapshot = var.skip_final_snapshot

  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    Name = "MsPostgres"
  }
}
