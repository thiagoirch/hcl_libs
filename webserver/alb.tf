resource "aws_lb" "alb_webserver" {
  name               = "alb-webserver"
  load_balancer_type = "application"
  security_groups    = [var.sgApp]
  subnets            = [var.subnetPub]
}

resource "aws_lb_listener" "http_webserver" {
  load_balancer_arn = aws_lb.alb_webserver.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_webserver" {
  load_balancer_arn = aws_lb.alb_webserver.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.webserver.arn

  default_action {
    target_group_arn = aws_lb_target_group.example.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "webserver" {
  name        = "example-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.example.id
  target_type = "instance"
}
