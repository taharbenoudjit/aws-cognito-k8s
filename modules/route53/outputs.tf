output "route53_zone_id" {
  value = aws_route53_record.this.id
}

output "cert_arn" {
  value = aws_acm_certificate.cert.arn
}