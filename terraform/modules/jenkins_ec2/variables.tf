variable "vpc_id" {}
variable "subnet_id" {}
variable "instance_profile" {}
variable "project_name" {}
variable "environment" {}
variable "tags" {
  type = map(string)
}


variable "public_key_path" {
  description = "Path to your public key (.pub)"
}
