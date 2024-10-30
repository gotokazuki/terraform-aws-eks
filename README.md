# aws-terraform-eks

This module creates an EKS cluster on AWS.

> [!WARNING]
> This module does not support the AMI for managed node groups based on Amazon Linux 2 (AL2).

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_eks_addon.coredns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.kube_proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_fargate_profile.eks_fargate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_fargate_profile) | resource |
| [aws_eks_node_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_instance_profile.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ebs_cni_sa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_fargate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ebs_cni_sa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_fargate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.eks_owned_eni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.eks_cluster_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.eks_cluster_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.eks_node_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.eks_node_ingress_from_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.eks_node_ingress_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [kubernetes_config_map.aws_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_namespace_v1.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ssm_parameter.eks_ami_image_id_arm64](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.eks_ami_image_id_x86_64](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [tls_certificate.eks_cluster_oidc](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_addon_coredns_version"></a> [eks\_addon\_coredns\_version](#input\_eks\_addon\_coredns\_version) | EKS addon version of coredns. | `string` | `null` | no |
| <a name="input_eks_addon_ebs_csi_driver_version"></a> [eks\_addon\_ebs\_csi\_driver\_version](#input\_eks\_addon\_ebs\_csi\_driver\_version) | EKS addon version of aws-ebs-csi-driver. | `string` | `null` | no |
| <a name="input_eks_addon_kube_proxy_version"></a> [eks\_addon\_kube\_proxy\_version](#input\_eks\_addon\_kube\_proxy\_version) | EKS addon version of kube-proxy. | `string` | `null` | no |
| <a name="input_eks_addon_vpc_cni_version"></a> [eks\_addon\_vpc\_cni\_version](#input\_eks\_addon\_vpc\_cni\_version) | EKS addon version of vpc-cni. | `string` | `null` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | Name of the EKS cluster. | `string` | n/a | yes |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | Kubernetes version of the EKS cluster. | `string` | n/a | yes |
| <a name="input_eks_enabled_cluster_log_types"></a> [eks\_enabled\_cluster\_log\_types](#input\_eks\_enabled\_cluster\_log\_types) | List of the desired control plane logging to enable. | `set(string)` | <pre>[<br>  "api",<br>  "audit"<br>]</pre> | no |
| <a name="input_eks_logs_retention_in_days"></a> [eks\_logs\_retention\_in\_days](#input\_eks\_logs\_retention\_in\_days) | Logs retention in days of the EKS cluster. | `number` | `7` | no |
| <a name="input_eks_managed_node_ami_type"></a> [eks\_managed\_node\_ami\_type](#input\_eks\_managed\_node\_ami\_type) | AMI type of managed nodes. | `string` | `"x86_64"` | no |
| <a name="input_eks_managed_node_capacity_type"></a> [eks\_managed\_node\_capacity\_type](#input\_eks\_managed\_node\_capacity\_type) | Capacity type of managed nodes. | `string` | `"SPOT"` | no |
| <a name="input_eks_managed_node_desired_size"></a> [eks\_managed\_node\_desired\_size](#input\_eks\_managed\_node\_desired\_size) | Desired size of managed nodes. | `number` | `1` | no |
| <a name="input_eks_managed_node_instance_types"></a> [eks\_managed\_node\_instance\_types](#input\_eks\_managed\_node\_instance\_types) | Instance type of managed nodes. | `set(string)` | n/a | yes |
| <a name="input_eks_managed_node_launch_template_version"></a> [eks\_managed\_node\_launch\_template\_version](#input\_eks\_managed\_node\_launch\_template\_version) | Launch template version of managed nodes. | `string` | n/a | yes |
| <a name="input_eks_managed_node_max_size"></a> [eks\_managed\_node\_max\_size](#input\_eks\_managed\_node\_max\_size) | Max size of managed nodes. | `number` | `1` | no |
| <a name="input_eks_managed_node_min_size"></a> [eks\_managed\_node\_min\_size](#input\_eks\_managed\_node\_min\_size) | Min size of managed nodes. | `number` | `1` | no |
| <a name="input_fargate_namespaces"></a> [fargate\_namespaces](#input\_fargate\_namespaces) | Namespace for using fargate. To use Fargate, you need to specify worker\_type = "fargate" in the labels of the manifest. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_fargate_pod_policy_arns"></a> [fargate\_pod\_policy\_arns](#input\_fargate\_pod\_policy\_arns) | Set of IAM policy for the fargate pods. | `set(string)` | <pre>[<br>  "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"<br>]</pre> | no |
| <a name="input_k8s_aws_auth_map_accounts"></a> [k8s\_aws\_auth\_map\_accounts](#input\_k8s\_aws\_auth\_map\_accounts) | AWS account numbers to automatically map IAM ARNs from. | `list(string)` | `[]` | no |
| <a name="input_k8s_aws_auth_map_roles"></a> [k8s\_aws\_auth\_map\_roles](#input\_k8s\_aws\_auth\_map\_roles) | Additional mapping for IAM roles and Kubernetes RBAC. | <pre>list(object({<br>    iam_role = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_k8s_aws_auth_map_users"></a> [k8s\_aws\_auth\_map\_users](#input\_k8s\_aws\_auth\_map\_users) | Additional mapping for IAM users and Kubernetes RBAC. | <pre>list(object({<br>    iam_user = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_namespaces"></a> [namespaces](#input\_namespaces) | Namespace for the EKS cluster. | `set(string)` | `[]` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix for resources. | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs of the private subnet. | `set(string)` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block of the VPC. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_certificate_authority"></a> [cluster\_certificate\_authority](#output\_cluster\_certificate\_authority) | Certificate authority of the EKS cluster. |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint of the EKS cluster. |
| <a name="output_cluster_iam_oidc_provider_arn"></a> [cluster\_iam\_oidc\_provider\_arn](#output\_cluster\_iam\_oidc\_provider\_arn) | OpenID Connect provider ARN of the EKS cluster. |
| <a name="output_cluster_iam_oidc_provider_url"></a> [cluster\_iam\_oidc\_provider\_url](#output\_cluster\_iam\_oidc\_provider\_url) | OpenID Connect provider URL of the EKS cluster. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Name of the EKS cluster. |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | Issuer URL on the EKS cluster for the OpenID Connect identity provider. |
| <a name="output_eks_cluster_security_group_id"></a> [eks\_cluster\_security\_group\_id](#output\_eks\_cluster\_security\_group\_id) | Security Group ID of the EKS cluster that generated automatically by EKS. |
| <a name="output_eks_node_security_group_id"></a> [eks\_node\_security\_group\_id](#output\_eks\_node\_security\_group\_id) | Security Group ID to allow access to the worker nodes. |
| <a name="output_eks_owned_eni_security_group_id"></a> [eks\_owned\_eni\_security\_group\_id](#output\_eks\_owned\_eni\_security\_group\_id) | Security Group ID to allow between the worker nodes and the control plane in the EKS cluster. |
| <a name="output_node_group_autoscaling_group_name"></a> [node\_group\_autoscaling\_group\_name](#output\_node\_group\_autoscaling\_group\_name) | Name of the auto scaling group for the EKS node group. |
