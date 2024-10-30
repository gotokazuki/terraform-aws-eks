resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles    = yamlencode(local.map_roles)
    mapUsers    = yamlencode(local.map_users)
    mapAccounts = yamlencode(local.map_accounts)
  }

  depends_on = [aws_eks_cluster.this]
}

resource "kubernetes_namespace_v1" "this" {
  for_each = var.namespaces

  metadata {
    name = each.value
  }

  depends_on = [aws_eks_cluster.this]
}
