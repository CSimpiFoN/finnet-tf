output "id" {
  value       = aws_cloudfront_distribution.s3_distribution.id
  description = "ID of the CF distribution"
}

output "arn" {
  value = aws_cloudfront_distribution.s3_distribution.arn
}

output "domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
