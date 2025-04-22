variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "region" {
  description = "The region of the EKS cluster"
  type        = string
}

variable "cidr" {
  description = "The CIDR of the EKS cluster"
  type        = string
  default     = "172.31.0.0/16"
}
