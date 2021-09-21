resource "aws_security_group" "ecs_service" {
  name        = "${var.service_name}-sg"
  description = "Security Group for ECS"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-sg"
  }

  ## Rule
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = [
      aws_security_group.alb.id,

    ]

  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}
