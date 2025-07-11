# variables.tf
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  default     = "cloud-resource-health-monitor"
}

variable "environment" {
  description = "Environment name"
  default     = "dev"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default = {
    Owner     = "tola"
    ManagedBy = "Terraform"
    Project   = "Cloud Resource Health Monitor"
  }
}

variable "key_name" {
  description = "Name of the EC2 key pair to use for ECS instances"
  type        = string
}

variable "prometheus_image_uri" {
  description = "ECR image URI for Prometheus container"
  type        = string
}

variable "grafana_image_uri" {
  description = "ECR image URI for Grafana container"
  type        = string
}
