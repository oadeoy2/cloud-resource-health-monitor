output "prometheus_service_arn" {
  value = aws_ecs_service.prometheus_service.id
}

output "grafana_service_arn" {
  value = aws_ecs_service.grafana_service.id
}
