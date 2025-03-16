variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}
variable "principal_arn" {
  description = "IAM user or role ARN."
  type        = string
}
variable "policy_arn" {
  description = "EKS access policy ARN."
  type        = string
}
variable "access_scope_type" {
  description = "Type of access scope."
  type        = string
}
variable "access_scope_namespaces" {
  description = "Namespaces to grant access to."
  type        = set(string)
  default     = []
}
