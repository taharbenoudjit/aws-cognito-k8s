resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = var.origin_bucket_domaine_name
    origin_id   = var.origin_bucket_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Cloud front for flutter application"
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = var.logging_bucket
    prefix          = var.logging_bucket_prefix
  }

  aliases = [var.domain_name]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.origin_bucket_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.restrictions_list
    }
  }

  tags = var.tags

  viewer_certificate {
     cloudfront_default_certificate = true
  }

}

resource "aws_route53_record" "www" {
  zone_id = var.route53_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = replace(aws_cloudfront_distribution.this.domain_name, "/[.]$/", "")
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = true
  }

  depends_on = [aws_cloudfront_distribution.this]
}