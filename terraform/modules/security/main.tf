# main.tf
resource "aws_security_group" "ecs_service_sg" {
  name        = "${var.project_name}-${var.environment}-ecs-sg"
  description = "Allow inbound from ALB, outbound to internet"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# variables.tf
variable "vpc_id" {}
variable "project_name" {}
variable "environment" {}
variable "tags" {
  type = map(string)
}

# outputs.tf
output "ecs_service_sg_id" {
  value = aws_security_group.ecs_service_sg.id
}
