variable "identifier" {
  description = "The identifier for the RDS instance"
  type        = string
  default     = "ms-database"
}

variable "database_name" {
  description = "The database name for the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage for the RDS instance"
  type        = number
  default     = 10
}

variable "database_port" {
  description = "The port of the database"
  type        = number
  default     = 5432
}

variable "database_engine" {
  description = "The engine of the database"
  type        = string
  default     = "postgres"
}

variable "database_engine_version" {
  description = "The engine version of the database"
  type        = string
  default     = "17.2"
}

variable "database_instance_class" {
  description = "The instance class of the database"
  type        = string
  default     = "db.t3.micro"
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot"
  type        = bool
  default     = true
}

variable "vpc_security_group_ids" {
  description = "The security group ids of the VPC"
  type        = list(string)
}
