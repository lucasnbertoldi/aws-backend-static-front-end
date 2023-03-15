locals {
    app_domain = join(".",["app",var.domain])
    api_domain = join(".", ["api", var.domain])
}

module "front-end" {
    source = "/modules/front-end/"
    id = var.id
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
    aws_region = var.aws_region
    env = var.env
    domain = local.app_domain
    route_53_zone_id = data.aws_route53_zone.domain_route53_zone.zone_id
    path_static_files = "/front-end/"
}

module "auto-scaling" {
    source = "/modules/auto-scaling/"
    id = var.id
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
    aws_region = var.aws_region
    env = var.env
    e2c_application_instance_type = "t3a.micro"
    e2c_application_volume_size = 8
    ami_id = data.aws_ami.java_11_tomcat_9_ami.id
    domain = local.api_domain
    route_53_zone_id = data.aws_route53_zone.domain_route53_zone.zone_id
    zones = ["us-east-1a", "us-east-1b"]    
    auto_scaling_cpu_percentage = 80.0
}

