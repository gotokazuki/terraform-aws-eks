resource "aws_eks_cluster" "this" {
  name     = "${var.prefix}-${var.eks_cluster_name}"
  role_arn = aws_iam_role.eks_cluster.arn

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

resource "aws_eks_fargate_profile" "eks_fargate" {
  for_each = var.fargate_namespaces

  cluster_name           = aws_eks_cluster.this.name
  fargate_profile_name   = "${var.prefix}-fargate-profile-${each.value}"
  pod_execution_role_arn = aws_iam_role.eks_fargate.arn
  subnet_ids             = var.private_subnet_ids

  selector {
    namespace = each.value
    labels = {
      workerType = "fargate"
    }
  }

  timeouts {
    create = "10m"
    delete = "10m"
  }

  depends_on = [
    kubernetes_config_map.aws_auth
  ]
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.prefix}-managed-node-group"
  node_role_arn   = aws_iam_role.eks_node.arn
  subnet_ids      = var.private_subnet_ids
  capacity_type   = var.eks_managed_node_capacity_type
  instance_types  = var.eks_managed_node_instance_types
  ami_type        = var.eks_managed_node_ami_type

  scaling_config {
    desired_size = var.eks_managed_node_desired_size
    max_size     = var.eks_managed_node_max_size
    min_size     = var.eks_managed_node_min_size
  }

  launch_template {
    version = var.eks_managed_node_launch_template_version
    id      = aws_launch_template.this.id
  }

  depends_on = [
    kubernetes_config_map.aws_auth,
    aws_launch_template.this,
  ]

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = "kube-proxy"
  addon_version               = var.eks_addon_kube_proxy_version
  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"

  depends_on = [aws_eks_cluster.this]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = "vpc-cni"
  addon_version               = var.eks_addon_vpc_cni_version
  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"


  depends_on = [aws_eks_cluster.this]
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = "coredns"
  addon_version               = var.eks_addon_coredns_version
  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"

  depends_on = [aws_eks_node_group.this]
}

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = var.eks_addon_ebs_csi_driver_version
  service_account_role_arn    = aws_iam_role.ebs_cni_sa.arn
  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"

  depends_on = [aws_eks_node_group.this]
}
