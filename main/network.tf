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


resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = join("-", [var.env, var.id, "subnet-1"])
    Environment = var.env
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = join("-", [var.env, var.id, "subnet-2"])
    Environment = var.env
  }
}

resource "aws_route_table_association" "subnet_1_association" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.table_route.id
}

resource "aws_route_table_association" "subnet_2_association" {
  subnet_id      = aws_subnet.subnet_2.id
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
    description      = "TLS from VPC on 80"
    from_port        = 80
    to_port          = 80
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
