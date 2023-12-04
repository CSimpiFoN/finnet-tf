terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  default_tags {
    tags = merge({Name: var.domain_name},{Environment: var.environment}, var.additional_tags)
  }
}
