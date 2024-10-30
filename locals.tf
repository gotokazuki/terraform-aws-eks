locals {
  map_roles = concat(
    [
      {
        rolearn  = aws_iam_role.eks_node.arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups = [
          "system:bootstrappers",
          "system:nodes",
        ]
      },
      {
        rolearn  = aws_iam_role.eks_fargate.arn
        username = "system:node:{{SessionName}}"
        groups = [
          "system:bootstrappers",
          "system:nodes",
          "system:node-proxier",
        ]
      }
    ],
    [
      for map_role in var.k8s_aws_auth_map_roles : {
        rolearn  = map_role.iam_role
        username = map_role.username
        groups   = try(map_role.groups, [])
      }
    ]
  )
  map_users = [
    for map_user in var.k8s_aws_auth_map_users : {
      userarn  = map_user.iam_user
      username = map_user.username
      groups   = try(map_user.groups, [])
    }
  ]
  map_accounts = var.k8s_aws_auth_map_accounts
}
