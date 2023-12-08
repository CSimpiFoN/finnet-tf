module "cloudfront" {
  for_each = {
    for key, value in var.static_sites :
    key => value
  }
  source = "../aws_cloudfront_distribution"

  path        = each.key
  environment = var.environment
  origins = {
    "s3_bucket" = {
      domain_name = module.s3_bucket[each.key].bucket_domain_name
      origin_path = join("", ["/", var.environment])
    }
  }
  default_cache_behavior = {
    target_origin_id = "s3_bucket"
  }
  cache_behaviours = [{
    path_pattern     = join("", ["/", each.key])
    target_origin_id = "s3_bucket"
  }
  ]
  bucket_arn = module.s3_bucket[each.key].bucket_arn
  bucket_id  = module.s3_bucket[each.key].bucket_id
}

module "s3_bucket" {
  for_each = {
    for key, value in var.static_sites :
    key => value
  }
  source = "../aws_s3_bucket"

  bucket_name = join("", ["Bucket", tostring(each.value.site_number), "_", var.environment])
  environment = var.environment
}