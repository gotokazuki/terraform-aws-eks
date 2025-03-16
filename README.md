# aws-terraform-eks

This module creates an EKS cluster with Auto Mode enabled on AWS.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_access_entry"></a> [access\_entry](#module\_access\_entry) | ./modules/access_entry | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_iam_instance_profile.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_cluster_auth_mode](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.eks_owned_eni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.eks_cluster_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.eks_cluster_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [tls_certificate.eks_cluster_oidc](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootstrap_cluster_creator_admin_permissions"></a> [bootstrap\_cluster\_creator\_admin\_permissions](#input\_bootstrap\_cluster\_creator\_admin\_permissions) | Whether to bootstrap the cluster creator with admin permissions. | `bool` | `true` | no |
| <a name="input_eks_access_entrys"></a> [eks\_access\_entrys](#input\_eks\_access\_entrys) | IAM users to access the EKS cluster. | <pre>map(object({<br>    iam                     = string<br>    policy                  = string<br>    access_scope_type       = string<br>    access_scope_namespaces = set(string)<br>  }))</pre> | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | Name of the EKS cluster. | `string` | n/a | yes |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | Kubernetes version of the EKS cluster. | `string` | n/a | yes |
| <a name="input_eks_enabled_cluster_log_types"></a> [eks\_enabled\_cluster\_log\_types](#input\_eks\_enabled\_cluster\_log\_types) | List of the desired control plane logging to enable. | `set(string)` | <pre>[<br>  "api",<br>  "audit"<br>]</pre> | no |
| <a name="input_eks_logs_retention_in_days"></a> [eks\_logs\_retention\_in\_days](#input\_eks\_logs\_retention\_in\_days) | Logs retention in days of the EKS cluster. | `number` | `7` | no |
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
