output "website_bucket_arn" {
  description = "ARN of the bucket"
  value       = module.s3-infra-bucket
}

output "website_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.s3-infra-bucket
}

output "website_bucket_domain" {
  description = "Domain name of the bucket"
  value       = module.s3-infra-bucket
}