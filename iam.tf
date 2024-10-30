resource "aws_iam_role" "eks_cluster" {
  name = "${var.prefix}-eks-cluster"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "eks.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )
}
# https://docs.aws.amazon.com/ja_jp/eks/latest/userguide/cluster-iam-role.html
resource "aws_iam_policy" "eks_cluster" {
  name = "${var.prefix}-eks-cluster"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateTags"
        ],
        "Resource" : "arn:aws:ec2:*:*:instance/*",
        "Condition" : {
          "ForAnyValue:StringLike" : {
            "aws:TagKeys" : "kubernetes.io/cluster/*"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeInstances",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeVpcs",
          "ec2:DescribeDhcpOptions",
          "ec2:DescribeAvailabilityZones",
          "kms:DescribeKey"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  policy_arn = aws_iam_policy.eks_cluster.arn
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role" "eks_node" {
  name = "${var.prefix}-eks-node"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow"
        }
      ]
  })
}

resource "aws_iam_instance_profile" "eks_node" {
  name = "${var.prefix}-eks-node"
  role = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks_node" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AutoScalingFullAccess",
  ])

  policy_arn = each.value
  role       = aws_iam_role.eks_node.name
}

resource "aws_iam_role" "eks_fargate" {
  name = "${var.prefix}-eks-fargate"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "eks-fargate-pods.amazonaws.com"
        },
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_fargate" {
  for_each = var.fargate_pod_policy_arns

  policy_arn = each.value
  role       = aws_iam_role.eks_fargate.name
}

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_cluster_oidc.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_role" "ebs_cni_sa" {
  name = "${var.prefix}-eks-ebs-cni-driver-service-account"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Principal" : {
          "Federated" : aws_iam_openid_connect_provider.this.arn
        },
        "Effect" : "Allow"
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.this.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ebs_cni_sa" {
  role       = aws_iam_role.ebs_cni_sa.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}
