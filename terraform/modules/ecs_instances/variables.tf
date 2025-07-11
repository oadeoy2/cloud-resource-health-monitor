variable "cluster_name" {}
variable "key_name" {}
variable "instance_profile_name" {}
variable "public_subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  description = "Security group ID for ECS instances"
  type        = string
}