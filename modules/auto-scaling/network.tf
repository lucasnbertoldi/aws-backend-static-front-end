resource "aws_subnet" "subnet" {
  count = length(var.zones)

  vpc_id     = var.vpc.id
  cidr_block = "10.0.${var.start_network_number + count.index}.0/24"
  availability_zone = var.zones[count.index]

  tags = {
    Name = join("-", [var.env, var.id, "auto-scaling-subnet-${count.index}"])
    Environment = var.env
  }
}

resource "aws_route_table_association" "subnet_association" {
  count = length(var.zones)
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = var.gw_table_route.id
}

resource "aws_security_group" "e2c_application_security_group" {
  name        = join("-", [var.env, var.id, "appication-security-group"])
  description = "Permitir porta 8080 para tomcat"
  vpc_id      = var.vpc.id

  ingress {
    description      = "TLS from VPC on 8080"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = [var.vpc.cidr_block]
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
  vpc_id      = var.vpc.id

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
