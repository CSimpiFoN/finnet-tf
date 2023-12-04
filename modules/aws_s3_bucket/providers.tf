terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  default_tags {
    tags = merge({Environment: var.environment}, var.additional_tags)
  }
}
