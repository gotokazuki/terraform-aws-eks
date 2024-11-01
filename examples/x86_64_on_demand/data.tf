data "aws_eks_cluster_auth" "this" {
  name = "${local.prefix}-${local.eks_cluster_name}"
}
