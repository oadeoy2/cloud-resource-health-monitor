# main.tf
resource "aws_ecr_repository" "backend" {
  name = "${var.project_name}-${var.environment}-backend"
  tags = var.tags
}

resource "aws_ecr_repository" "frontend" {
  name = "${var.project_name}-${var.environment}-frontend"
  tags = var.tags
}

# variables.tf
variable "project_name" {}
variable "environment" {}
variable "tags" {
  type = map(string)
}

# outputs.tf
output "backend_repo_url" {
  value = aws_ecr_repository.backend.repository_url
}

output "frontend_repo_url" {
  value = aws_ecr_repository.frontend.repository_url
}