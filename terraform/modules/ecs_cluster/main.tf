# main.tf
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-${var.environment}-cluster"
  tags = var.tags
}

# variables.tf
variable "project_name" {}
variable "environment" {}
variable "tags" {
  type = map(string)
}

# outputs.tf
output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}