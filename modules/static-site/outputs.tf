output "domain_names" {
  value = [
    for cf in module.cloudfront : cf.domain_name
  ]
}