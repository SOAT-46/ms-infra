module "cluster" {
  source = "../../modules/aws_cluster"

  account_id   = var.account_id
  cluster_name = var.cluster_name
  role_arn     = data.aws_iam_role.labrole.arn

  vpc_id  = data.aws_vpc.vpc.id
  subnets = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.region}e"]
}

module "node" {
  source = "../../modules/aws_node"

  cluster_name = module.cluster.cluster_name
  role_arn     = data.aws_iam_role.labrole.arn

  subnets = [for subnet in data.aws_subnet.subnet : subnet.id]

  node_max_size     = var.node_max_size
  node_min_size     = var.node_min_size
  node_desired_size = var.node_desired_size

  depends_on = [module.cluster]
}

module "security_group" {
  source = "../../modules/aws_security_groups"
}

locals {
  database_name = "videos"
  environment       = "dev"
  video_crud_image  = "soat46/ms-video:latest"
  mail_sender_image = "soat46/ms-mail:latest"
}

module "rds" {
  source = "../../modules/aws_rds"

  database_name = local.database_name
  vpc_security_group_ids = [module.security_group.database_security_group_id]

  depends_on = [module.security_group]
}
