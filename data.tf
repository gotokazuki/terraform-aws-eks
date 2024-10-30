data "aws_caller_identity" "current" {}
data "tls_certificate" "eks_cluster_oidc" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}
# https://docs.aws.amazon.com/eks/latest/userguide/retrieve-ami-id.html
data "aws_ssm_parameter" "eks_ami_image_id_x86_64" {
  name = "/aws/service/eks/optimized-ami/${var.eks_cluster_version}/amazon-linux-2023/x86_64/standard/recommended/image_id"
}
data "aws_ssm_parameter" "eks_ami_image_id_arm64" {
  name = "/aws/service/eks/optimized-ami/${var.eks_cluster_version}/amazon-linux-2023/arm64/standard/recommended/image_id"
}
