terraform {
  required_version = ">= 1.6.4"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.29.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = merge({Environment: var.environment}, var.additional_tags)
  }
}
