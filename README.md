<h4>Static Site Terraform Setup</h4>
Terraform Code to set up AWS S3 bucket and CloudFront Distributions<r>

<h6>Code Structure</h6>

```
.
├── modules
│   ├── aws_cloudfront_distribution
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── variables.tf
│   └── aws_s3_bucket
│       ├── main.tf
│       ├── outputs.tf
│       ├── providers.tf
│       └── variables.tf
├── backend.tf
├── cloudfront_distributions.tf
├── outputs.tf
├── README.md
├── s3_buckets.tf
└── variables.tf
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.4 |

- HTTP Remote state store for backend<br>
- AWS account<br>

## Providers

| Name                                                       | Version |
|------------------------------------------------------------|---------|
| <a name="provider_vault"></a> [aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)    | >= 5.29.0  |

## Modules
### aws_cloudfront_distribution
Local module to create and configure CloudFront Distributions<br>
[./modules/aws_cloudfront_distribution](https://github.com/CSimpiFoN/finnet-tf/tree/main/modules/aws_cloudfront_distribution)<br>
Called by main module

#### Main Inputs
| Name                                                                            | Description                                      | Type          | Default | Required |
|---------------------------------------------------------------------------------|--------------------------------------------------|---------------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment)             | System environment (dev, staging, prd)           | `string`      | `N/A`   |   yes    |
| <a name="input_path"></a> [path](#input\_path)                                  | Path pattern                                     | `string`      | `N/A`   |   yes    |
| <a name="input_enabled"></a> [enabled](#input\_enabled)                         | Whether if the CF distribution is enabled or not | `bool`        | `true`  |   no     |
| <a name="input_is_ipv6_enabled"></a> [is_ipv6_enabled](#input\_is_ipv6_enabled) | Whether if IPv6 enabled or not                   | `bool`        | `true`  |   no     |
| <a name="input_default_root_object"></a> [default_root_object](#input\_default_root_object) | File name of the default root object | `string`      | `"index.html"`| no   |
| <a name="input_price_class"></a> [price_class](#input\_price_class)             | Price class for this distribution.               | `string` | `"PriceClass_100"` |   no |
| <a name="input_aliases"></a> [aliases](#input\_aliases)                         | List of domain aliases                           | `list(string)`| `null`   |   no    |
| <a name="input_origins"></a> [origins](#input\_origins)                         | CloudFront origins                               | `map(object)` | `{}`     |   no    |
| <a name="input_default_cache_behavior"></a> [default_cache_behavior](#input\_default_cache_behavior) | Default cache behaviour settings| `object     ` | `N/A`     |   yes  |
| <a name="input_cache_behaviours"></a> [cache_behaviours](#input\_cache_behaviours) | Ordered cache behaviours                      | `list(object)`| `[]`     |   no    |
| <a name="input_geo_restriction_type"></a> [geo_restriction_type](#input\_geo_restriction_type) | Method that you want to use to restrict distribution of your content               | `string`      | `"none"`   |   no    |
| <a name="input_geo_restriction_locations"></a> [geo_restriction_locations](#input\_geo_restriction_locations) | ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist) | `list(string)`| `[]`     |   no    |
| <a name="input_minimum_protocol_version"></a> [minimum_protocol_version](#input\_minimum_protocol_version) | Minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections    | `string`      | `"TLSv1.2_2021"`|   no |
| <a name="input_additional_tags"></a> [additional_tags](#input\_additional_tags) | Additional resource tags                               | `map(string)` | `null`     |   no    |

### aws_3_bucket
Local module to create and configure S3 Buckets<br>
[./modules/aws_s3_bucket](https://github.com/CSimpiFoN/finnet-tf/tree/main/modules/aws_s3_bucket)<br>
Called by main module
| Name                                                                | Description                                                          | Type      | Default | Required |
|---------------------------------------------------------------------|----------------------------------------------------------------------|-----------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | System environment (dev, staging, prd)                               | `string`  | `N/A`   |   yes    |
| <a name="input_bucket_name"></a> [bucket_name](#input\_bucket_name) | Name of the S3 bucket                                                | `string`  | `N/A`   |   yes    |
| <a name="input_force_destroy"></a> [force_destroy](#input\_force_destroy) | If the service needs to be exposed                             | `boolean` | `false` |    no    |
| <a name="input_object_lock_enabled"></a> [object_lock_enabled](#input\_object_lock_enabled) | Whether object block is enabled or not       | `bool`    | `false` |    no    |
| <a name="input_bucket_accelerate_status"></a> [bucket_accelerate_status](#input\_bucket_accelerate_status) | Transfer acceleration state of the bucket | `string`  | `"Suspended"`    |    no    |
| <a name="input_expected_bucket_owner"></a> [expected_bucket_owner](#input\_expected_bucket_owner) | Account ID of the expected bucket owner| `string`  | `null`   |   no    |
| <a name="input_block_public_acls"></a> [block_public_acls](#input\_block_public_acls) | Whether to block public ACLs                       | `bool`    | `true`   |   no    |
| <a name="input_block_public_policy"></a> [block_public_policy](#input\_block_public_policy) | Whether to block public policy               | `bool`    | `true`   |   no    |
| <a name="input_ignore_public_acls"></a> [ignore_public_acls](#input\_ignore_public_acls) | Whether to ignore public ACLs                   | `bool`    | `true`   |   no    |
| <a name="input_restrict_public_buckets"></a> [restrict_public_buckets](#input\_restrict_public_buckets) | Whether to restrict public buckets | `bool`  | `true`   |   no    |
| <a name="input_bucket_acl"></a> [bucket_acl](#input\_bucket_acl) | The canned ACL to apply                                              | `string`  | `"private"` |   no    |
| <a name="input_object_ownership"></a> [object_ownership](#input\_object_ownership) | Object ownership                      | `string`  | `"BucketOwnerPreferred"` |   no    |
| <a name="input_versioning_enabled"></a> [versioning_enabled](#input\_versioning_enabled) | Versioning state of the bucket               | `string`  | `"Enabled"` |   no    |
| <a name="input_additional_tags"></a> [additional_tags](#input\_additional_tags) | Additional resource tags                                | `map(string)`  | `{}` |   no    |
| <a name="input_s3_objects"></a> [s3_objects](#input\_s3_objects) | S3 objects to upload into the bucket                                   | `map(object)`  | `{}` |   no    |
| <a name="input_cloudfront_arn"></a> [cloudfront_arn](#input\_cloudfront_arn) | ARN of the CF distribution to access the bucket           | `list(string)` | `N/A` |   yes   |

# Usage
## Mandatory environmental variables
- TF_HTTP_ADDRESS - Address of the state store
- TF_VAR_environment - System environment to deploy/manage (dev, staging, prod)

!Important notes!<br>
Highly advised to use separate state stores per environment to lower blast radius<br>

To add a new URI with dedicated CF and S3, add the corresponding code to the cloudfront_distributions.tf, s3_buckets.tf and outputs.tf<br>
Replace the '#' with actual number and 'uri' with URI like /path
```
module "cloudfront_#" {
  source = "./modules/aws_cloudfront_distribution"

  path        = "uri"
  environment = var.environment
  origins = {
    "s3_bucket_1" = {
      domain_name = module.s3_bucket_#.bucket_domain_name
      origin_path = join("", ["/", var.environment])
    }
  }
  default_cache_behavior = {
    target_origin_id = "s3_bucket_#"
  }
  cache_behaviours = [{
    path_pattern     = "/uri"
    target_origin_id = "s3_bucket_#"
  }
  ]
}
```
```
module "s3_bucket_#" {
  source = "./modules/aws_s3_bucket"

  bucket_name = join("", ["Bucket#_", var.environment])
  cloudfront_arn = [module.cloudfront_#.arn]
  environment = var.environment
}
```
```
output "domain_name_#" {
  value = module.cloudfront_#.domain_name
}
```

# Design decisions
The code has been designed to be modular for easy change and extension, the 2 different resource types have their own modules prepared.<br>
- Small modules have been written to make it possible to make changes to every related environment/cf/s3 centrally. So after a change, a re-deployment picks the changes up everywhere
- As many options got a default value as possible in order to make it easier to add new setups, and reduce code duplication
- Deployments are prepared to be separated by environment

The necessary setting and policies/attachments, access control resources are all managed in the respective modules

# Integration into CI/CD
- The code can be integrated into a CI/CD pipeline by running Terraform for each <i>environment</i> by child pipelines and, storing the states in a remote store relying on <b>TF_VAR_environment</b> environmental variable
With this, changes can be deployed to respective environments separately, without affecting other environments, so every change can go through the full deployment cycle
- Add <i>terraform fmt</i> to the pipeline to ensure code quality
- Better way to make the pipeline pull always up-to-date modules from an external source rather than using internal modules

# Other considerations for production usage
- Apply human friendly DNS name for the CloudFront endpoints with AWS-managed SSL certificates
- Use only 1 CloudFront distribution and S3 bucket per environment for simplicity and cost savings
