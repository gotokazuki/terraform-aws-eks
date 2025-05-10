variable "prefix" {
  description = "Name prefix for resources."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.prefix))
    error_message = "The prefix must only contain lowercase letters, numbers, and hyphens."
  }
}

# eks
variable "eks_cluster_name" {
  description = "Name of the EKS cluster."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.eks_cluster_name))
    error_message = "The cluster name must only contain lowercase letters, numbers, and hyphens."
  }
}
## https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html
variable "eks_cluster_version" {
  description = "Kubernetes version of the EKS cluster. Currently supports 1.32."
  type        = string

  validation {
    condition     = contains(["1.32"], var.eks_cluster_version)
    error_message = "The EKS cluster version must be one of: 1.32."
  }
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

  validation {
    condition = alltrue([
      for log_type in var.eks_enabled_cluster_log_types : contains([
        "api",
        "audit",
        "authenticator",
        "controllerManager",
        "scheduler"
      ], log_type)
    ])
    error_message = "Invalid log type. Valid values are: api, audit, authenticator, controllerManager, scheduler."
  }
}
variable "eks_logs_retention_in_days" {
  description = "Logs retention in days of the EKS cluster."
  type        = number
  default     = 7

  validation {
    condition     = var.eks_logs_retention_in_days >= 1 && var.eks_logs_retention_in_days <= 3653
    error_message = "Log retention must be between 1 and 3653 days."
  }
}
variable "eks_access_entries" {
  description = "IAM users to access the EKS cluster."
  type = map(object({
    iam                     = string
    policy                  = string
    access_scope_type       = string
    access_scope_namespaces = set(string)
  }))

  validation {
    condition = alltrue([
      for entry in var.eks_access_entries : contains([
        "namespace",
        "cluster"
      ], entry.access_scope_type)
    ])
    error_message = "Access scope type must be either namespace or cluster."
  }
}
variable "eks_endpoint_public_access" {
  description = "Whether the Amazon EKS public API server endpoint is enabled."
  type        = bool
  default     = true
}

variable "eks_endpoint_private_access" {
  description = "Whether the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = false
}

# network
variable "vpc_id" {
  description = "ID of the VPC."
  type        = string

  validation {
    condition     = can(regex("^vpc-[0-9a-f]{17}$", var.vpc_id))
    error_message = "The VPC ID must be a valid AWS VPC ID."
  }
}
variable "vpc_cidr_block" {
  description = "CIDR block of the VPC."
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "The VPC CIDR block must be a valid IPv4 CIDR block."
  }
}
variable "private_subnet_ids" {
  description = "IDs of the private subnet."
  type        = set(string)

  validation {
    condition = alltrue([
      for subnet_id in var.private_subnet_ids : can(regex("^subnet-[0-9a-f]{17}$", subnet_id))
    ])
    error_message = "All subnet IDs must be valid AWS subnet IDs."
  }
}
