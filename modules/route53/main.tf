resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_zone" "this" {
  name         = var.domain_name
}

resource "aws_route53_record" "this" {
  zone_id = aws_route53_zone.this.zone_id
  name    = tolist(aws_acm_certificate.cert.domain_validation_options)[0]["resource_record_name"]
  type    = tolist(aws_acm_certificate.cert.domain_validation_options)[0]["resource_record_type"]
  records = [tolist(aws_acm_certificate.cert.domain_validation_options)[0]["resource_record_value"]]
  ttl     = var.ttl
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.this.fqdn]
}

# output "certs" {
#   value = tolist(aws_acm_certificate.cert.domain_validation_options)[0]["resource_record_name"]
# }
