resource "aws_lb" "alb_webserver" {
  name               = "alb-webserver"
  load_balancer_type = "application"
  security_groups    = [var.sgApp]
  enable_http2          = true
  enable_cross_zone_load_balancing = true
  enable_deletion_protection = false
  subnets            = var.snPub
}

resource "aws_lb_listener" "http_webserver" {
  load_balancer_arn = aws_lb.alb_webserver.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.webserver.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "webserver" {
  name        = "webserver"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.VPCIds
  target_type = "instance"
}
