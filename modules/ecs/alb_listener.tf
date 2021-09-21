resource "aws_lb_listener" "prod" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.blue.arn
    type             = "forward"
  }

  lifecycle {
    ignore_changes = [default_action]
  }

}

resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.this.arn
  port              = 10080
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.green.arn
    type             = "forward"
  }

  lifecycle {
    ignore_changes = [default_action]
  }

}
