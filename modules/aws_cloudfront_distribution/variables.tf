variable "environment" {
  type        = string
  description = "System environment. dev, stg, prd"
}

variable "domain_name" {
  type        = string
  description = "CF domain name"
}

variable "origin_domain_name" {
  type        = string
  description = "Default origin domain name"
}

variable "origin_id" {
  type        = string
  description = "Unique identifier for the origin"
}

variable "enabled" {
  type        = bool
  description = "Whether if the CF distribution is enabled or not"
  default     = true
}

variable "is_ipv6_enabled" {
  type        = bool
  description = "Whether if IPv6on the CF distribution is enabled or not"
  default     = true
}

variable "default_root_object" {
  type        = string
  description = "File name of the default root object"
  default     = "index.html"
}

variable "price_class" {
  type        = string
  description = "Price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  default     = "PriceClass_100"
}

variable "aliases" {
  type        = list(string)
  description = "List of domain aliases"
  default     = null
}

variable "default_cache_behavior"{
  description = "Default cache behaviour settings"
  type = object({
    allowed_methods        = optional(list(string), ["GET", "HEAD"])
    cached_methods         = optional(list(string), ["GET", "HEAD"])
    target_origin_id       = string
    viewer_protocol_policy = optional(string, "redirect-to-https")
    min_ttl                = optional(number, 0)
    default_ttl            = optional(number, 3600)
    max_ttl                = optional(number, 86400)
    compress               = optional(bool, true)
  })
}

variable "cache_behaviours" {
  type = list(object({
    path_pattern           = string
    allowed_methods        = optional(list(string), ["GET", "HEAD"])
    cached_methods         = optional(list(string), ["GET", "HEAD"])
    target_origin_id       = string
    viewer_protocol_policy = optional(string, "redirect-to-https")
    min_ttl                = optional(number, 0)
    default_ttl            = optional(number, 3600)
    max_ttl                = optional(number, 86400)
    compress               = optional(bool, true)
  }))
  default = []
}

variable "geo_restriction_type" {
  type        = string
  description = "Method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist"
  default     = "none"
}

variable "geo_restriction_locations" {
  type        = list(string)
  description = "ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist). If the type is specified as none an empty array can be used"
  default     = []
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional resource tags"
  default     = null
}
