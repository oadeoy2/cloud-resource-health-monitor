resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-${var.environment}-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "cpu_high_backend" {
  alarm_name          = "${var.project_name}-${var.environment}-cpu-backend-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "This alarm triggers when backend CPU usage exceeds 85%"
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = "backend-service"
  }
  alarm_actions = [aws_sns_topic.alerts.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_high_frontend" {
  alarm_name          = "${var.project_name}-${var.environment}-cpu-frontend-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "This alarm triggers when frontend CPU usage exceeds 85%"
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = "frontend-service"
  }
  alarm_actions = [aws_sns_topic.alerts.arn]
}
