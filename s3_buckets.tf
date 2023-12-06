module "s3_bucket_1" {
  source = "./modules/aws_s3_bucket"

  bucket_name = join("", ["Bucket1_", var.environment])
  cloudfront_arn = [module.cloudfront_1.arn]
  environment = var.environment
}

module "s3_bucket_2" {
  source = "./modules/aws_s3_bucket"

  bucket_name = join("", ["Bucket2_", var.environment])
  cloudfront_arn = [module.cloudfront_2.arn]
  environment = var.environment
}

module "s3_bucket_3" {
  source = "./modules/aws_s3_bucket"

  bucket_name = join("", ["Bucket1_", var.environment])
  cloudfront_arn = [module.cloudfront_3.arn]
  environment = var.environment
}
