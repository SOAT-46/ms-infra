locals {
  default_instance_type = "t3.small"
}

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

  instance_type = local.default_instance_type

  node_max_size     = var.node_max_size
  node_min_size     = var.node_min_size
  node_desired_size = var.node_desired_size

  depends_on = [module.cluster]
}

module "security_group" {
  source = "../../modules/aws_security_groups"
}

locals {
  namespace_name = "soat-video-flow"
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

module "rabbitmq" {
  source = "../../modules/helm_rabbitmq"

  cluster_name = module.cluster.cluster_name
}

module "namespace" {
  source = "../../modules/k8s_namespace"

  namespace = local.namespace_name
}

module "video_crud" {
  source = "../../modules/k8s_deployment"
  container_image    = local.video_crud_image
  container_name     = "video-crud"
  environment        = local.environment
  namespace          = module.namespace.name
  is_ingress_enabled = false
  is_service_enabled = true

  config_map_data = {
    RABBITMQ_SEND_QUEUE = "process-video"
    RABBITMQ_UPDATE_QUEUE = "update-video-status"
  }

  secret_data = {
    DB_HOST = module.rds.db_endpoint
    DB_USER = module.rds.normal_username
    DB_PASS = module.rds.normal_password
    DB_PORT = module.rds.db_port

    RABBITMQ_USER = module.rabbitmq.rabbitmq_credentials.user
    RABBITMQ_PASS = module.rabbitmq.rabbitmq_credentials.password
    RABBITMQ_HOST = module.rabbitmq.rabbitmq_internal_service
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
