variable "project_name" {}
variable "environment" {}
variable "cluster_id" {}
variable "prometheus_image_uri" {}
variable "grafana_image_uri" {}
variable "ecs_task_exec_role_arn" {}
variable "tags" {
  type = map(string)
}

variable "alb_listener_arn" {}
variable "vpc_id" {}
