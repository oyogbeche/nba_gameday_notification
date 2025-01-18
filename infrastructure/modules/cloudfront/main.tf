resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name = var.origin_domain_name
    origin_id   = var.origin_id

    custom_origin_config {
      http_port              = var.origin_http_port
      https_port             = var.origin_https_port
      origin_protocol_policy = var.origin_protocol_policy
      origin_ssl_protocols   = var.origin_ssl_protocols
    }
  }

  default_cache_behavior {
    target_origin_id       = var.origin_id
    viewer_protocol_policy = var.viewer_protocol_policy

    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    forwarded_values {
      query_string = var.forward_query_string

      cookies {
        forward = var.forward_cookies
      }
    }
    compress = var.enable_compression
    min_ttl     = var.min_ttl
    default_ttl = var.default_ttl
    max_ttl     = var.max_ttl
  }

  price_class = var.price_class
  enabled     = var.enabled

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }

  viewer_certificate {
    minimum_protocol_version       = var.minimum_protocol_version
    cloudfront_default_certificate = var.cloudfront_default_certificate
  }

  tags = var.tags
}
