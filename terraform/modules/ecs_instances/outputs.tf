output "ecs_ami_id" {
  value = data.aws_ssm_parameter.ecs_ami.value
}
