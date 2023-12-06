<h4>Static Site Terraform Setup</h4>
Terraform Code to set up AWS S3 bucket and CloudFront Distributions<r>

<h6>Code Structure</h6>
.<br>
├── modules<br>
│   ├── aws_cloudfront_distribution<br>
│   │   ├── main.tf<br>
│   │   ├── outputs.tf<br>
│   │   ├── providers.tf<br>
│   │   └── variables.tf<br>
│   └── aws_s3_bucket<br>
│       ├── main.tf<br>
│       ├── outputs.tf<br>
│       ├── providers.tf<br>
│       └── variables.tf<br>
├── backend.tf<br>
├── cloudfront_distributions.tf<br>
├── outputs.tf<br>
├── README.md<br>
├── s3_buckets.tf<br>
└── variables.tf<br>

<h6>Requirements</h6>
- Terraform v1.6.4 or later
- HTTP Remote state store for backend
- AWS account

<h6>Design decisions</h6>
The code has been designed to be modular for easy change and extension, the 2 different resource types have their own modules prepared.<br>
- AWS S3 bucket module to manage store the files of the static files
- AWS CloudFront Distribution to allow the access to the website resources
- Deployments are prepared to be separate per environment

The necessary setting and policies/attachments, access control resources are all managed in the respective modules<br>

<h6>Usage</h6>
<h7>Mandatory environmental variables</h7>
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
