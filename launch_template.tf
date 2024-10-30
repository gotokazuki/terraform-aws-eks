resource "aws_launch_template" "this" {
  name = "${var.prefix}-eks-managed-node-launch-template"

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

  image_id = nonsensitive(data.aws_ssm_parameter.eks_ami_image_id.value)
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    CLUSTER_NAME = aws_eks_cluster.this.name
    ENDPOINT     = aws_eks_cluster.this.endpoint
    CA           = aws_eks_cluster.this.certificate_authority[0].data
    CIDR         = aws_eks_cluster.this.kubernetes_network_config[0].service_ipv4_cidr
  }))
  update_default_version = true
}
