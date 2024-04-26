# variables.tf
variable "aws_region" {
  description = "AWS region for the S3 bucket"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "maintenance_html" {
  description = "Provide the path to maintenance page"
  type        = string
}

