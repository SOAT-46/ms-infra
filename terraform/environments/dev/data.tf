data "aws_vpc" "vpc" {
  cidr_block = var.cidr
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

data "aws_iam_role" "labrole" {
  name = "LabRole"
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.cluster.cluster_name
}
