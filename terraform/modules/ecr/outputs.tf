# outputs.tf
output "backend_repo_url" {
  value = aws_ecr_repository.backend.repository_url
}

output "frontend_repo_url" {
  value = aws_ecr_repository.frontend.repository_url
}

output "prometheus_repo_url" {
  value = aws_ecr_repository.prometheus.repository_url
}

output "grafana_repo_url" {
  value = aws_ecr_repository.grafana.repository_url
}
