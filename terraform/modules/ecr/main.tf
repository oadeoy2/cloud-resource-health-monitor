# main.tf
resource "aws_ecr_repository" "backend" {
  name = "${var.project_name}-${var.environment}-backend"
  tags = var.tags
}

resource "aws_ecr_repository" "frontend" {
  name = "${var.project_name}-${var.environment}-frontend"
  tags = var.tags
}

resource "aws_ecr_repository" "prometheus" {
  name = "${var.project_name}-${var.environment}-prometheus"
  tags = var.tags
}

resource "aws_ecr_repository" "grafana" {
  name = "${var.project_name}-${var.environment}-grafana"
  tags = var.tags
}

resource "aws_ecr_repository" "node_exporter" {
  name = "${var.project_name}-${var.environment}-node-exporter"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}