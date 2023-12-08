variable "static_sites" {
  description = "Static sites to create"
  type = map(object({
    site_number = number
  }))
}

variable "environment" {
  type        = string
  description = "System environment"
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional resource tags"
  default     = null
}
