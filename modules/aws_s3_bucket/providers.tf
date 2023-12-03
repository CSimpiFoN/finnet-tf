terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      tags_all = {
        environment = merge(var.environment, var.additional_tags)
      }
    }
  }
}
