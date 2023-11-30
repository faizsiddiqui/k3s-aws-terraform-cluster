resource "random_string" "unique_id" {
  length  = 6
  special = false
}

resource "aws_secretsmanager_secret" "kubeconfig_secret" {
  name        = "${local.kubeconfig_secret_name}-${random_string.unique_id.result}"
  description = "Kubeconfig k3s. Cluster name: ${var.cluster_name}, environment: ${var.environment}"

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    local.global_tags,
    {
      "Name" = lower("${local.kubeconfig_secret_name}")
    }
  )
}