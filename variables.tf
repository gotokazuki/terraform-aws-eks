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
## https://aws.amazon.com/ec2/instance-types/?nc1=h_ls
variable "eks_managed_node_instance_types" {
  description = "Instance type of managed nodes."
  type        = set(string)
}
variable "eks_managed_node_desired_size" {
  description = "Desired size of managed nodes."
  type        = number
  default     = 1
}
variable "eks_managed_node_max_size" {
  description = "Max size of managed nodes."
  type        = number
  default     = 1
}
variable "eks_managed_node_min_size" {
  description = "Min size of managed nodes."
  type        = number
  default     = 1
}
variable "eks_managed_node_launch_template_version" {
  description = "Launch template version of managed nodes."
  type        = string
}
variable "eks_managed_node_capacity_type" {
  description = "Capacity type of managed nodes."
  type        = string
  default     = "SPOT"
}
variable "eks_managed_node_ami_type" {
  description = "AMI type of managed nodes."
  type        = string
  default     = "x86_64"

  validation {
    condition     = contains(["x86_64", "arm64"], var.eks_managed_node_ami_type)
    error_message = "Allowed values for eks_managed_node_ami_type are \"x86_64\", \"arm64\"."
  }
}
variable "eks_managed_node_volume_size" {
  description = "Volume size of managed nodes. (GiB)"
  type        = number
  default     = 20
}
variable "k8s_aws_auth_map_roles" {
  description = "Additional mapping for IAM roles and Kubernetes RBAC."
  type = list(object({
    iam_role = string
    username = string
    groups   = list(string)
  }))
  default = []
}
variable "k8s_aws_auth_map_users" {
  description = "Additional mapping for IAM users and Kubernetes RBAC."
  type = list(object({
    iam_user = string
    username = string
    groups   = list(string)
  }))
  default = []
}
variable "k8s_aws_auth_map_accounts" {
  description = "AWS account numbers to automatically map IAM ARNs from."
  type        = list(string)
  default     = []
}
## https://awscli.amazonaws.com/v2/documentation/api/latest/reference/eks/describe-addon-versions.html
## aws eks describe-addon-versions --kubernetes-version <version> --addon-name kube-proxy --query 'addons[].addonVersions[].addonVersion'
variable "eks_addon_kube_proxy_version" {
  description = "EKS addon version of kube-proxy."
  type        = string
  default     = null
}
## aws eks describe-addon-versions --kubernetes-version <version> --addon-name vpc-cni --query 'addons[].addonVersions[].addonVersion'
variable "eks_addon_vpc_cni_version" {
  description = "EKS addon version of vpc-cni."
  type        = string
  default     = null
}
## aws eks describe-addon-versions --kubernetes-version <version> --addon-name coredns --query 'addons[].addonVersions[].addonVersion'
variable "eks_addon_coredns_version" {
  description = "EKS addon version of coredns."
  type        = string
  default     = null
}
## aws eks describe-addon-versions --kubernetes-version <version> --addon-name aws-ebs-csi-driver --query 'addons[].addonVersions[].addonVersion'
variable "eks_addon_ebs_csi_driver_version" {
  description = "EKS addon version of aws-ebs-csi-driver."
  type        = string
  default     = null
}
variable "fargate_namespaces" {
  description = "Namespace for using fargate. To use Fargate, you need to specify worker_type = \"fargate\" in the labels of the manifest."
  type        = set(string)
  default = [
    "default"
  ]
}
variable "namespaces" {
  description = "Namespace for the EKS cluster."
  type        = set(string)
  default     = []
}
variable "fargate_pod_policy_arns" {
  description = "Set of IAM policy for the fargate pods."
  type        = set(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy",
  ]
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
