resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
   tags = {
    Environment = var.env
    Name = join("-", [var.env, var.id, "vpc"])
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Environment = var.env
    Name = join("-", [var.env, var.id, "gw"])
  }
}

resource "aws_route_table" "table_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = join("-", [var.env, var.id, "table-router"])
    Environment = var.env
  }
}