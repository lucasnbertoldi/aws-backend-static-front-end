resource "aws_acm_certificate" "site_certificate" {
  domain_name       = var.domain
  validation_method = "DNS"

  tags = {
    Environment = var.env
  }
}


resource "aws_route53_record" "site_route53_certificate_record" {
  for_each = {
    for dvo in aws_acm_certificate.site_certificate.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = var.route_53_zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}

resource "aws_acm_certificate_validation" "site_aws_acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.site_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.site_route53_certificate_record : record.fqdn]
}