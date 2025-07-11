output "jenkins_private_key_pem" {
  value     = module.jenkins_ec2.jenkins_private_key_pem
  sensitive = true
}

output "jenkins_public_ip" {
  value = module.jenkins_ec2.jenkins_public_ip
}

output "backend_repo_url" {
  value = module.ecr.backend_repo_url
}

output "frontend_repo_url" {
  value = module.ecr.frontend_repo_url
}

output "prometheus_repo_url" {
  value = module.ecr.prometheus_repo_url
}

output "grafana_repo_url" {
  value = module.ecr.grafana_repo_url
}

output "key_name" {
  value = var.key_name
}
