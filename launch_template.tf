resource "aws_launch_template" "this" {
  name = "${var.prefix}-eks-managed-node-launch-template"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.eks_managed_node_volume_size
      volume_type           = "gp3"
      encrypted             = true
      iops                  = 1000
      throughput            = 125
      kms_key_id            = aws_kms_key.eks_node.arn
      delete_on_termination = true
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.eks_node.id]
    delete_on_termination       = true
  }

  dynamic "tag_specifications" {
    for_each = ["instance", "volume"]

    content {
      resource_type = tag_specifications.value
      tags = {
        Name = "${var.prefix}-eks-managed-node"
      }
    }
  }

  image_id = var.eks_managed_node_ami_type == "x86_64" ? nonsensitive(data.aws_ssm_parameter.eks_ami_image_id_x86_64.value) : nonsensitive(data.aws_ssm_parameter.eks_ami_image_id_arm64.value)
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    CLUSTER_NAME = aws_eks_cluster.this.name
    ENDPOINT     = aws_eks_cluster.this.endpoint
    CA           = aws_eks_cluster.this.certificate_authority[0].data
    CIDR         = aws_eks_cluster.this.kubernetes_network_config[0].service_ipv4_cidr
  }))
  update_default_version = true
}
