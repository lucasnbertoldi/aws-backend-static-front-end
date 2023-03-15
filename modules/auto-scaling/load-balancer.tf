module "certificate" {
    source = "/modules/certificate/"
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
    aws_region = var.aws_region
    env = var.env
    domain = var.domain
    route_53_zone_id = var.route_53_zone_id
}


resource "aws_lb" "lb" {
  name               = join("-", [var.env, var.id, "lb"])
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_security_group.id]
  subnets            = aws_subnet.subnet[*].id
  tags = {
    Environment = var.env
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = join("-", [var.env, var.id, "lb-target-group"])
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    interval            = 30
    path                = "/"
    port                = 8080
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    matcher             = "200"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = module.certificate.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
  
}


resource "aws_route53_record" "lb_record" {
  zone_id = var.route_53_zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_lb.lb.dns_name
    zone_id                = aws_lb.lb.zone_id
    evaluate_target_health = true
  }
}