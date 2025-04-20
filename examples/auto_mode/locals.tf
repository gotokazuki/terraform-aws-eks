locals {
  prefix = "test-dev"

  ipv4_cidr         = "10.0.0.0/16"
  ipv4_cidr_newbits = 3
  subnets_number    = 2

  eks_cluster_name    = "example"
  eks_cluster_version = "1.32"
  eks_access_entries = {
    # key = {
    #   iam                     = "arn:aws:iam::123456789012:user/name"
    #   policy                  = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
    #   access_scope_type       = "cluster"
    #   access_scope_namespaces = []
    # }
  }

  default_tags = {
    owner      = "ownername"
    repository = "terraform-aws-eks"
    created_by = "terraform"
  }
}
