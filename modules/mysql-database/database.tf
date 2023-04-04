
resource "aws_db_subnet_group" "subnet" {
  name       = join("-", [var.env, var.id, "subnet-db-group"])
  subnet_ids = aws_subnet.subnet[*].id

  tags = {
    Environment = var.env
    Name = join("-", [var.env, var.id, "subnet-db-group"])
  }
}

resource "aws_security_group" "sc" {
  name        = join("-", [var.env, var.id, "db-security-group"])
  description = "Permitir porta 3306 para o banco de dados"
  vpc_id      = var.vpc.id

  ingress {
    description      = "TLS from VPC on 3306"
    from_port        = 3306
    to_port          = 3306
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


resource "aws_db_instance" "database" {
  allocated_storage    = var.storage
  max_allocated_storage = var.max_storage
  storage_type         = "gp2"
  identifier           = join("-", [var.env, var.id, "mysql-rds"])
  engine               = "mysql"
  engine_version       = var.mysql_version == 8 ? "8.0.32" : "5.7.40"
  instance_class       = var.database_instance_type
  username             = var.user_name
  password             = var.password
  parameter_group_name = "default.mysql${var.mysql_version == 8 ? "8.0" : "5.7"}"
  skip_final_snapshot  = true
  multi_az             = true
  port                 = 3306
  publicly_accessible  = false
  network_type         = "IPV4"
  db_subnet_group_name = aws_db_subnet_group.subnet.name
  vpc_security_group_ids = [aws_security_group.sc.id]
  allow_major_version_upgrade = false
  auto_minor_version_upgrade = false
  backup_retention_period = 7
  backup_window = "07:00-07:30"
}
