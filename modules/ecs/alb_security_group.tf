resource "aws_security_group" "alb" {
  name        = "${var.alb_name}-sg"
  description = "Security Group for ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.alb_name}-sg"
  }

  ## Rule
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      var.my_remote_ip,
    ]

  }

  ingress {
    from_port = 10080
    to_port   = 10080
    protocol  = "tcp"

    cidr_blocks = [
      var.my_remote_ip,
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
