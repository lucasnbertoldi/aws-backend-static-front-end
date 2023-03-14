locals {
    app_domain = join(".",["app",var.domain])
}

module "certificate" {
    source = "/modules/certificate/"
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
    aws_region = var.aws_region
    env = var.env
    domain = local.app_domain
    route_53_zone_id = data.aws_route53_zone.domain_route53_zone.zone_id
}

module "s3-app" {
    source = "/modules/site-s3/"
    id = var.id
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
    aws_region = var.aws_region
    env = var.env
    domain = local.app_domain
    certificate_arn = module.certificate.certificate_arn
    route_53_zone_id = data.aws_route53_zone.domain_route53_zone.zone_id
    path_static_files = "/front-end/"
}

