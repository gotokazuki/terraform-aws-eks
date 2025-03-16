data "aws_caller_identity" "current" {}
data "tls_certificate" "eks_cluster_oidc" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}
