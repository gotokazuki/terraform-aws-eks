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

  prefix                                          = local.prefix
  eks_cluster_name                                = local.eks_cluster_name
  eks_cluster_version                             = local.eks_cluster_version
  eks_bootstrap_cluster_creator_admin_permissions = true
  eks_enabled_cluster_log_types = [
    "api",
    "authenticator",
    "controllerManager",
    "scheduler",
    "audit",
  ]
  eks_logs_retention_in_days = 30
  eks_access_entries         = local.eks_access_entries

  vpc_id             = module.network.vpc_id
  vpc_cidr_block     = module.network.vpc_cidr_block
  private_subnet_ids = module.network.private_subnet_ids
}
