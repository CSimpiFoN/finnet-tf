output "bucket_id" {
  value       = aws_s3_bucket.bucket.id
  description = "ID of the S3 bucket"
}

output "bucket_domain_name" {
  value = aws_s3_bucket.bucket.bucket_domain_name
  description = "Domain name of the S3 bucket"
}