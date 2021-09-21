resource "aws_lb_target_group" "blue" {
  name        = "${var.alb_name}-tg-1"
  port        = 80
  protocol    = "HTTP"
  target_type = var.target_type
  vpc_id      = var.vpc_id

  health_check {
    path                = var.health_check_path
    protocol            = "HTTP"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = 200
  }

  deregistration_delay = 10

}

resource "aws_lb_target_group" "green" {
  name        = "${var.alb_name}-tg-2"
  port        = 80
  protocol    = "HTTP"
  target_type = var.target_type
  vpc_id      = var.vpc_id

  health_check {
    path                = var.health_check_path
    protocol            = "HTTP"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = 200
  }

  deregistration_delay = 10

}