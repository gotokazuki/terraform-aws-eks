output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = aws_eks_cluster.this.name
}
output "cluster_endpoint" {
  description = "Endpoint of the EKS cluster."
  value       = aws_eks_cluster.this.endpoint
}
output "cluster_certificate_authority" {
  description = "Certificate authority of the EKS cluster."
  value       = aws_eks_cluster.this.certificate_authority[0].data
}
output "cluster_iam_oidc_provider_arn" {
  description = "OpenID Connect provider ARN of the EKS cluster."
  value       = aws_iam_openid_connect_provider.this.arn
}
output "cluster_iam_oidc_provider_url" {
  description = "OpenID Connect provider URL of the EKS cluster."
  value       = aws_iam_openid_connect_provider.this.url
}
output "cluster_oidc_issuer_url" {
  description = "Issuer URL on the EKS cluster for the OpenID Connect identity provider."
  value       = aws_eks_cluster.this.identity[0].oidc[0].issuer
}
output "eks_owned_eni_security_group_id" {
  description = "Security Group ID to allow between the worker nodes and the control plane in the EKS cluster."
  value       = aws_security_group.eks_owned_eni.id
}
output "eks_cluster_security_group_id" {
  description = "Security Group ID of the EKS cluster that generated automatically by EKS."
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}
