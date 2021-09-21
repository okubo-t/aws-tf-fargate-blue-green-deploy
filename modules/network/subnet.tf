# public subnet
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_a["cidr"]
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_a["name"]
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_c["cidr"]
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_c["name"]
  }
}

# private subnet
resource "aws_subnet" "private_subnet_a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_subnet_a["cidr"]
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_a["name"]
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_subnet_c["cidr"]
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_c["name"]
  }
}