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


resource "aws_subnet" "subnet" {
  count = length(var.zones)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = var.zones[count.index]

  tags = {
    Name = join("-", [var.env, var.id, "subnet-${count.index}"])
    Environment = var.env
  }
}

resource "aws_route_table_association" "subnet_association" {
  count = length(var.zones)
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.table_route.id
}

resource "aws_security_group" "e2c_application_security_group" {
  name        = join("-", [var.env, var.id, "appication-security-group"])
  description = "Permitir porta 8080 para tomcat"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "TLS from VPC on 8080"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "lb_security_group" {
  name        = join("-", [var.env, var.id, "lb-security-group"])
  description = "Permitir porta 80 para o balanceamento de carga"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "TLS from VPC on 443"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
