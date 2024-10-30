resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/eks/${var.prefix}-${var.eks_cluster_name}/cluster"
  retention_in_days = var.eks_logs_retention_in_days
}
