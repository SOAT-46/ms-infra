variable "sg_name" {
  description = "The name of the security group"
  type        = string
  default     = "ms"
}

variable "sg_prefix" {
  description = "The prefix of the security group"
  type        = string
  default     = "rds-sg"
}

variable "cidr" {
  description = "The cidr for security group"
  type        = string
  default     = "0.0.0.0/0"
}
