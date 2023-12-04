module "cloudfront" {
  source = "./modules/aws_cloudfront_distribution"

  domain_name            = "tjuhasztest.williamhill.com"
  environment            = var.environment
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

module "s3_bucket_1" {
  source = "./modules/aws_s3_bucket"

  bucket_name    = "wh-testbucket-1"
  environment    = var.environment
  cloudfront_arn = [module.cloudfront.arn]

  s3_objects = {
    "/dev/index.html" = {
      source       = templatefile("./index.html", { environment = var.environment })
      content_type = "text/html"
    }
  }
}

#module "s3_bucket_2" {
#  source = "./modules/aws_s3_bucket"

#  bucket_name = "wh_testbucket_2"
#  environment = var.environment
#}

#module "s3_bucket_3" {
#  source = "./modules/aws_s3_bucket"

#  bucket_name = "wh_testbucket_3"
#  environment = var.environment
#}