output "ecs_task_exec_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

output "ec2_instance_profile" {
  value = aws_iam_instance_profile.ec2_profile.name
}