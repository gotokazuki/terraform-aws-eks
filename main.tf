resource "aws_eks_cluster" "this" {
  name     = "${var.prefix}-${var.eks_cluster_name}"
  role_arn = aws_iam_role.eks_cluster.arn

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = var.eks_bootstrap_cluster_creator_admin_permissions
  }

  bootstrap_self_managed_addons = false

  compute_config {
    enabled       = true
    node_pools    = ["general-purpose"]
    node_role_arn = aws_iam_role.eks_node.arn
  }

  kubernetes_network_config {
    elastic_load_balancing {
      enabled = true
    }
  }

  storage_config {
    block_storage {
      enabled = true
    }
  }

  vpc_config {
    security_group_ids = tolist([
      aws_security_group.eks_owned_eni.id,
    ])
    subnet_ids              = var.private_subnet_ids
    endpoint_public_access  = true
    endpoint_private_access = true
  }

  version                   = var.eks_cluster_version
  enabled_cluster_log_types = var.eks_enabled_cluster_log_types

  tags = {
    Name = "${var.prefix}-${var.eks_cluster_name}"
  }

  depends_on = [aws_cloudwatch_log_group.this]
}

module "access_entry" {
  for_each = var.eks_access_entries

  source = "./modules/access_entry"

  cluster_name            = aws_eks_cluster.this.name
  principal_arn           = each.value.iam
  policy_arn              = each.value.policy
  access_scope_type       = each.value.access_scope_type
  access_scope_namespaces = each.value.access_scope_namespaces

  depends_on = [aws_eks_cluster.this]
}
