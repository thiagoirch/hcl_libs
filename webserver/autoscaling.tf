data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_configuration" "lc_webserver" {
  name          = "ls-webserver"
  image_id      = data.aws_ami.amzlinux.id
  instance_type = "t3.medium"
  security_groups = []
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 10
    throughput            = 300
    delete_on_termination = true
  }

}

resource "aws_autoscaling_group" "asg_webserver" {
  name                      = "asg-webserver"
  launch_configuration      = aws_launch_configuration.lc_webserver.name
  min_size                  = 2
  max_size                  = 5
  desired_capacity          = 2
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
  statistic           = "average"
  threshold           = "40"
  alarm_description   = "Utilização de CPU"
  alarm_actions       = [aws_autoscaling_policy.sip_webserver.arn]
  dimensions          = {
    AutoScalingGroupName = aws_autoscaling_group.asg_webserver.id
  }
}