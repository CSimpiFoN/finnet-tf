module "cloudfront_1" {
  source = "./modules/aws_cloudfront_distribution"

  path        = "auth"
  environment = var.environment
  origins = {
    "s3_bucket_1" = {
      domain_name = module.s3_bucket_1.bucket_domain_name
      origin_path = join("", ["/", var.environment])
    }
  }
  default_cache_behavior = {
    target_origin_id = "s3_bucket_1"
  }
  cache_behaviours = [{
    path_pattern     = "/auth"
    target_origin_id = "s3_bucket_1"
  }
  ]
}

module "cloudfront_2" {
  source = "./modules/aws_cloudfront_distribution"

  path        = "info"
  environment = var.environment
  origins = {
    "s3_bucket_2" = {
      domain_name = module.s3_bucket_2.bucket_domain_name
      origin_path = join("", ["/", var.environment])
    }
  }
  default_cache_behavior = {
    target_origin_id = "s3_bucket_2"
  }
  cache_behaviours = [{
    path_pattern     = "/info"
    target_origin_id = "s3_bucket_2"
  }
  ]
}

module "cloudfront_3" {
  source = "./modules/aws_cloudfront_distribution"

  path        = "customers"
  environment = var.environment
  origins = {
    "s3_bucket_3" = {
      domain_name = module.s3_bucket_3.bucket_domain_name
      origin_path = join("", ["/", var.environment])
    }
  }
  default_cache_behavior = {
    target_origin_id = "s3_bucket_3"
  }
  cache_behaviours = [{
    path_pattern     = "/customers"
    target_origin_id = "s3_bucket_3"
  }
  ]
}
