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
