# main.tf
resource "aws_ecr_repository" "backend" {
  name = "${var.project_name}-${var.environment}-backend"
  tags = var.tags
}

resource "aws_ecr_repository" "frontend" {
  name = "${var.project_name}-${var.environment}-frontend"
  tags = var.tags
}
