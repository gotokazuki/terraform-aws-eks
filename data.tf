data "aws_caller_identity" "current" {}
data "aws_ami" "eks_node" {
  owners      = ["602401143452"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.eks_cluster_version}-*"]
  }
}
data "tls_certificate" "eks_cluster_oidc" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}
data "aws_ssm_parameter" "eks_ami_image_id" {
  name = "/aws/service/eks/optimized-ami/${var.eks_cluster_version}/amazon-linux-2023/x86_64/standard/recommended/image_id"
}
