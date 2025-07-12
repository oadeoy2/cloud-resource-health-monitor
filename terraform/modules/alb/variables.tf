variable "project_name" {}
variable "environment" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "alb_sg_id" {}
variable "tags" {
  type = map(string)
}

variable "alb_name" {
  type = string
}