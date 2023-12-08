resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  comment             = join(" ", [var.environment, var.path, "CF distribution"])
  default_root_object = var.default_root_object
  price_class         = var.price_class

  aliases = var.aliases

  dynamic origin {
    for_each = {
      for key, value in var.origins :
      key => value
    }
    content {
      domain_name = origin.value.domain_name
      origin_id   = origin.key
      origin_path = origin.value.origin_path
      origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_s3_oac.id
    }
  }

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
    minimum_protocol_version      = var.minimum_protocol_version
  }

  lifecycle {
    ignore_changes = [web_acl_id]
  }
}

resource "aws_cloudfront_origin_access_control" "cloudfront_s3_oac" {
  name                              = join(" ", [var.environment, var.path, "S3 OAC"])
  description                       = join(" ", [var.environment, var.path, "CF origin access control"])
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_s3_bucket_policy" "cdn-oac-bucket-policy" {
  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    sid     = "AllowCloudFrontServicePrincipal"
    actions = [ "s3:GetObject" ]
    resources = [ "${var.bucket_arn}/${var.environment}/*" ]
    principals {
      type = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test = "StringEquals"
      variable = "AWS:SourceArn"
      values = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}

