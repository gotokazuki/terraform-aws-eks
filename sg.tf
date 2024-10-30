# eks_control_plane (EKS Cluster additional sg)
resource "aws_security_group" "eks_owned_eni" {
  name        = "${var.prefix}-eks-owned-eni"
  description = "Allow communication between the worker nodes and the Kubernetes control plane in the EKS cluster"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.prefix}-eks-owned_eni"
  }
}

resource "aws_security_group_rule" "eks_cluster_ingress" {
  security_group_id = aws_security_group.eks_owned_eni.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "eks_cluster_egress" {
  security_group_id = aws_security_group.eks_owned_eni.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group" "eks_node" {
  name        = "${var.prefix}-eks-node"
  description = "EKS Node"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.prefix}-eks-node"
  }
}

resource "aws_security_group_rule" "eks_node_ingress_from_cluster" {
  for_each = toset(["tcp", "udp"])

  security_group_id        = aws_security_group.eks_node.id
  type                     = "ingress"
  description              = "Allow access from cluster"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = each.value
  source_security_group_id = aws_security_group.eks_owned_eni.id
}

resource "aws_security_group_rule" "eks_node_ingress_internal" {
  security_group_id = aws_security_group.eks_node.id
  type              = "ingress"
  description       = "Allow internal access"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.vpc_cidr_block]
}

resource "aws_security_group_rule" "eks_node_egress" {
  security_group_id = aws_security_group.eks_node.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}
