variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.32"
}

variable "role_arn" {
  description = "The ARN of the IAM role"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID for the cluster"
  type        = string
}

variable "auth_mode" {
  description = "The EKS access mode"
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "account_id" {
  default = "AWS Account ID"
  type    = string
}

variable "policy_arn" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "subnets" {
  description = "The subnets for the EKS"
  type        = list(string)
}

variable "cidr" {
  description = "The CIDR for ingress and egress"
  type        = string
  default     = "0.0.0.0/0"
}
