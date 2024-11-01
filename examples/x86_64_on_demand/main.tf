module "network" {
  source = "git@github.com:gotokazuki/terraform-aws-network.git?ref=v0.1.0"

  prefix                 = local.prefix
  ipv4_cidr              = local.ipv4_cidr
  ipv4_cidr_newbits      = local.ipv4_cidr_newbits
  subnets_number         = local.subnets_number
  create_private_subnets = true
}

module "eks" {
  source = "../../"

  prefix              = local.prefix
  eks_cluster_name    = local.eks_cluster_name
  eks_cluster_version = local.eks_cluster_version
  eks_enabled_cluster_log_types = [
    "api",
    "authenticator",
    "controllerManager",
    "scheduler",
    "audit",
  ]
  eks_logs_retention_in_days               = 30
  eks_managed_node_instance_types          = local.eks_managed_node_instance_types
  eks_managed_node_capacity_type           = local.eks_managed_node_capacity_type
  eks_managed_node_desired_size            = 2
  eks_managed_node_max_size                = 3
  eks_managed_node_min_size                = 2
  eks_managed_node_launch_template_version = "$Latest"
  eks_managed_node_ami_type                = local.eks_managed_node_ami_type
  eks_managed_node_volume_size             = 20

  fargate_namespaces = [
    "default",
    "fargate",
  ]
  namespaces = [
    "fargate",
  ]

  fargate_pod_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  ]

  k8s_aws_auth_map_roles    = []
  k8s_aws_auth_map_users    = local.k8s_aws_auth_map_users
  k8s_aws_auth_map_accounts = []

  vpc_id             = module.network.vpc_id
  vpc_cidr_block     = module.network.vpc_cidr_block
  private_subnet_ids = module.network.private_subnet_ids
}
