variable "prefix" {
  description = "Name prefix for resources."
  type        = string
}

# eks
variable "eks_cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}
## https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html
variable "eks_cluster_version" {
  description = "Kubernetes version of the EKS cluster."
  type        = string
}
variable "eks_bootstrap_cluster_creator_admin_permissions" {
  description = "Whether to bootstrap the cluster creator with admin permissions."
  type        = bool
  default     = true
}
variable "eks_enabled_cluster_log_types" {
  description = "List of the desired control plane logging to enable."
  type        = set(string)
  default = [
    "api",
    "audit",
  ]
}
variable "eks_logs_retention_in_days" {
  description = "Logs retention in days of the EKS cluster."
  type        = number
  default     = 7
}
variable "eks_access_entrys" {
  description = "IAM users to access the EKS cluster."
  type = map(object({
    iam                     = string
    policy                  = string
    access_scope_type       = string
    access_scope_namespaces = set(string)
  }))
}

# network
variable "vpc_id" {
  description = "ID of the VPC."
  type        = string
}
variable "vpc_cidr_block" {
  description = "CIDR block of the VPC."
  type        = string
}
variable "private_subnet_ids" {
  description = "IDs of the private subnet."
  type        = set(string)
}
