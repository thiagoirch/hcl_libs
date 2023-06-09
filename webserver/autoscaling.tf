resource "aws_autoscaling_group" "asg_webserver" {
  name                      = "asg-webserver"
  launch_configuration      = aws_launch_configuration.lc_webserver.name
  min_size                  = 2
  max_size                  = 5
  desired_capacity          = 2
  vpc_zone_identifier = var.subnetApp
}

resource "aws_autoscaling_policy" "sop_webserver" {
  name                   = "sop_webserver"
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1

  autoscaling_group_name = aws_autoscaling_group.asg_webserver.id
}

resource "aws_autoscaling_policy" "sip_webserver" {
  name                   = "sip_webserver"
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1

  autoscaling_group_name = aws_autoscaling_group.asg_webserver.id
}

resource "aws_cloudwatch_metric_alarm" "soa_webserver" {
  alarm_name          = "soa-webserver"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Utilização de CPU"
  alarm_actions       = [aws_autoscaling_policy.sop_webserver.arn]
  dimensions          = {
    AutoScalingGroupName = aws_autoscaling_group.asg_webserver.id
  }
}

resource "aws_cloudwatch_metric_alarm" "sia_webserver" {
  alarm_name          = "sia-webserver"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = "40"
  alarm_description   = "Utilização de CPU"
  alarm_actions       = [aws_autoscaling_policy.sip_webserver.arn]
  dimensions          = {
    AutoScalingGroupName = aws_autoscaling_group.asg_webserver.id
  }
}