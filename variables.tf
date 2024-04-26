variable "region" {
  description = "AWS region"
  type = string
}
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}
variable "maintenance_html" {
  description = "Provide the path to maintenance page"
  type        = string
}