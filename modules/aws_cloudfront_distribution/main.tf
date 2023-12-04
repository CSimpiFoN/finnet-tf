resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.origin_domain_name
    origin_id   = var.origin_id
  }

  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  comment             = join(" ", [var.environment, var.domain_name, "CF distribution"])
  default_root_object = var.default_root_object
  price_class         = var.price_class

  aliases = var.aliases

  default_cache_behavior {
    allowed_methods  = var.default_cache_behavior.allowed_methods
    cached_methods   = var.default_cache_behavior.cached_methods
    target_origin_id = var.default_cache_behavior.target_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = var.default_cache_behavior.viewer_protocol_policy
    min_ttl                = var.default_cache_behavior.min_ttl
    default_ttl            = var.default_cache_behavior.default_ttl
    max_ttl                = var.default_cache_behavior.max_ttl
    compress               = var.default_cache_behavior.compress
  }

  dynamic ordered_cache_behavior {
    for_each = {
      for key, value in var.cache_behaviours :
      key => value
    }
    content {
      path_pattern           = ordered_cache_behavior.value.path_pattern
      allowed_methods        = ordered_cache_behavior.value.allowed_methods
      cached_methods         = ordered_cache_behavior.value.cached_methods
      target_origin_id       = ordered_cache_behavior.value.target_origin_id
      viewer_protocol_policy = ordered_cache_behavior.value.viewer_protocol_policy
      min_ttl                = ordered_cache_behavior.value.min_ttl
      default_ttl            = ordered_cache_behavior.value.default_ttl
      max_ttl                = ordered_cache_behavior.value.max_ttl
      compress               = ordered_cache_behavior.value.compress

      forwarded_values {
        query_string = false
        headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }

  viewer_certificate {
   cloudfront_default_certificate = true
  }

  lifecycle {
    ignore_changes = [web_acl_id]
  }
}

#resource "aws_acm_certificate" "cert" {
#  domain_name               = var.domain_name
#  subject_alternative_names = var.aliases

#  lifecycle {
#    create_before_destroy = true
#  }
#}
