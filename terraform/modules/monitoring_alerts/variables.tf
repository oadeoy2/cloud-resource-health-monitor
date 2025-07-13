variable "project_name" {}
variable "environment" {}
variable "cluster_name" {}
variable "alert_email" {}
variable "tags" {
  type = map(string)
}
