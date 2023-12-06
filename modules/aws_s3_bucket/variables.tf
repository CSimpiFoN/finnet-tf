variable "environment" {
  type        = string
  description = "System environment. dev, stg, prd"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "force_destroy" {
  type        = bool
  description = "Boolean that indicates all objects (including any locked objects) should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error."
  default     = false
}

variable "object_lock_enabled" {
  type        = bool
  description = "Whether object block is enabled or not"
  default     = false
}

variable "bucket_accelerate_status" {
  type        = string
  description = "Transfer acceleration state of the bucket. Valid values: Enabled, Suspended"
  default     = "Suspended"
}

variable "expected_bucket_owner" {
  type        = string
  description = "Account ID of the expected bucket owner"
  default     = null
}

variable "block_public_acls" {
  type        = bool
  description = "Whether to block public ACLs"
  default     = true
}

variable "block_public_policy" {
  type        = bool
  description = "Whether to block public policy"
  default     = true
}

variable "ignore_public_acls" {
  type        = bool
  description = "Whether to ignore public ACLs"
  default     = true
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Whether to restrict public buckets"
  default     = true
}

variable "bucket_acl" {
  type        = string
  description = "The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write"
  default     = "private"
}

variable "object_ownership" {
  type        = string
  description = "Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced"
  default     = "BucketOwnerPreferred"
}

variable "versioning_enabled" {
  type        = string
  description = "Versioning state of the bucket. Valid values: Enabled, Suspended, or Disabled"
  default     = "Enabled"
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional resource tags"
  default     = null
}

variable "s3_objects" {
  description = "S3 objects to upload into the bucket"
  type = map(object({
    content      = optional(string, null)
    content_type = optional(string, null)
  }))
  default = {}
}

variable "cloudfront_arn" {
  type        = list(string)
  description = "ARN of the CF distribution to access the bucket"
}
