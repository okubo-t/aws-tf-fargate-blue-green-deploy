resource "aws_vpc" "this" {
  cidr_block           = var.vpc["cidr"]
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.vpc["name"]
  }
}