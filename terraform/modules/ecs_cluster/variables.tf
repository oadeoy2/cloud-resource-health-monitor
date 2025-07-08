# variables.tf
variable "project_name" {}
variable "environment" {}
variable "tags" {
  type = map(string)
}

variable "backend_image_uri" {}
variable "cluster_id" {}

variable "frontend_image_uri" {
  description = "ECR image URI for the frontend container"
  type        = string
}

variable "ecs_task_exec_role_arn" {
  description = "IAM Role ARN for ECS Task Execution"
  type        = string
}

