resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled
}

resource "aws_s3_bucket_accelerate_configuration" "bucket_accelerate" {
  bucket                = aws_s3_bucket.bucket.id
  status                = var.bucket_accelerate_status
  expected_bucket_owner = var.expected_bucket_owner
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {

  bucket = aws_s3_bucket.bucket.id
  acl    = var.bucket_acl

  depends_on = [aws_s3_bucket_ownership_controls.ownership]
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.versioning_enabled
  }
}

resource "aws_s3_object" "object" {
  for_each = {
    for key, value in var.s3_objects :
    key => value
  }

  bucket       = var.bucket_name
  acl          = var.bucket_acl
  key          = each.key
  content      = each.value.content
  content_type = each.value.content_type

  depends_on = [aws_s3_bucket.bucket]
}
