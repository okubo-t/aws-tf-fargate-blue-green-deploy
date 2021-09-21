resource "aws_lb" "this" {
  name               = var.alb_name
  load_balancer_type = "application"
  internal           = false

  security_groups = [aws_security_group.alb.id, ]

  subnets = var.subnet_ids

  tags = {
    Name = var.alb_name

  }
}
