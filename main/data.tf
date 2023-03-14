data "aws_route53_zone" "domain_route53_zone" {
  name         = var.domain
  private_zone = false
}

data "aws_ami" "java_11_tomcat_9_ami" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["${var.ami_e2c_application_name}*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}