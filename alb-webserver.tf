data "aws_security_group" "cloudfront_origins_sg" {
  filter {
    name   = "tag:Name"
    values = ["sg-default-cloudfront-vpc-origins"]
  }
}

resource "aws_lb" "alb_webserver" {
  name               = "alb-webserver"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id, data.aws_security_group.cloudfront_origins_sg.id]
  subnets            = [aws_subnet.sub_private_app_1a.id, aws_subnet.sub_private_app_1b.id]

  enable_deletion_protection = true

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-ALB-WebServer"
    }
  )
}

# Target group for the ALB
resource "aws_lb_target_group" "alb_webserver" {
  name     = "tg-webserver-80"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-basic.id

  health_check {
    enabled             = true
    path                = "/"
    port                = var.app_port
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-TG-ALB-WebServer"
    }
  )
}

# Attach the EC2 instance to the target group
resource "aws_lb_target_group_attachment" "alb_webserver" {
  target_group_arn = aws_lb_target_group.alb_webserver.arn
  target_id        = aws_instance.webserver.id
  port             = var.app_port
}

/* # HTTPS Listener (Port 443)
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb_webserver.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = ""

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_webserver.arn
  }
} */

/* # HTTP Listener (Port 80) - Redirect to HTTPS
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb_webserver.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
} */