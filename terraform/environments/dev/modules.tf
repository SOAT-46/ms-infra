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

locals {
  environment       = "dev"
  video_crud_image  = "soat46/ms-video:latest"
  mail_sender_image = "soat46/ms-mail:latest"
}

module "namespace" {
  source = "../../modules/k8s_namespace"

  namespace = "soat-video-flow"
}

module "video_crud" {
  source             = "../../modules/k8s_deployment"
  container_image    = local.video_crud_image
  container_name     = "video-crud"
  environment        = local.environment
  namespace          = module.namespace.name
  is_ingress_enabled = false
  is_service_enabled = true

  config_map_data = {

  }

  secret_data = {

  }

  container_resources = {
    requests = {
      cpu    = "250m"
      memory = "64Mi"
    }
    limits = {
      cpu    = "1000m"
      memory = "512Mi"
    }
  }
}

module "mail_sender" {
  source             = "../../modules/k8s_deployment"
  container_image    = local.mail_sender_image
  container_name     = "mail-sender"
  environment        = local.environment
  namespace          = module.namespace.name
  is_ingress_enabled = false
  is_service_enabled = true

  config_map_data = {

  }

  secret_data = {

  }

  container_resources = {
    requests = {
      cpu    = "250m"
      memory = "64Mi"
    }
    limits = {
      cpu    = "1000m"
      memory = "512Mi"
    }
  }
}
