terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "s3-infra-bucket" {
  source = "./s3-module"
  aws_region = var.region
  maintenance_html = var.maintenance_html
  bucket_name = var.bucket_name

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}