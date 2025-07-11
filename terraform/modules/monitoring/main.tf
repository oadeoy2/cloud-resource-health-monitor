resource "aws_ecs_task_definition" "prometheus" {
  family                   = "${var.project_name}-prometheus"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_task_exec_role_arn

  container_definitions = jsonencode([{
    name      = "prometheus"
    image     = var.prometheus_image_uri
    essential = true
    portMappings = [{
      containerPort = 9090
      hostPort      = 9090
    }]
  }])
}

resource "aws_ecs_service" "prometheus_service" {
  name            = "prometheus-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.prometheus.arn
  desired_count   = 1
  launch_type     = "EC2"

  depends_on = [aws_ecs_task_definition.prometheus]
}

resource "aws_ecs_task_definition" "grafana" {
  family                   = "${var.project_name}-grafana"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_task_exec_role_arn

  container_definitions = jsonencode([{
    name      = "grafana"
    image     = var.grafana_image_uri
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
    }]
  }])
}

resource "aws_ecs_service" "grafana_service" {
  name            = "grafana-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.grafana.arn
  desired_count   = 1
  launch_type     = "EC2"

  depends_on = [aws_ecs_task_definition.grafana]
}
