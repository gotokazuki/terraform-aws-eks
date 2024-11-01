locals {
  prefix                    = "test-dev"
  ipv4_cidr                 = "10.0.0.0/16"
  ipv4_cidr_newbits         = 3
  subnets_number            = 2
  eks_cluster_name          = "example"
  eks_cluster_version       = "1.30"
  eks_managed_node_ami_type = "x86_64"
  eks_managed_node_instance_types = [
    "t3.medium",
    "t2.medium",
  ]
  k8s_aws_auth_map_users = [
    {
      iam_user = "arn:aws:iam::xxxxxxxxxx:user/username"
      username = "username"
      groups = [
        "system:masters",
      ]
    }
  ]
  default_tags = {
    owner      = "ownername"
    repository = "terraform-aws-eks"
    created_by = "terraform"
  }
}
