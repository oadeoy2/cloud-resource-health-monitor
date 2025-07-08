# variables.tf
variable "vpc_id" {}
variable "project_name" {}
variable "environment" {}
variable "tags" {
  type = map(string)
}