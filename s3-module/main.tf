resource "aws_s3_bucket" "hosting_bucket" {
  bucket = var.bucket_name
   tags = var.tags
}

resource "aws_s3_bucket_ownership_controls" "maintenance_bucket_oc" {
  bucket = aws_s3_bucket.hosting_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#Added public access block
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.hosting_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "hosting_bucket_policy" {
  bucket = aws_s3_bucket.hosting_bucket.id
  
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "PublicReadGetObject",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": [
          "${aws_s3_bucket.hosting_bucket.arn}",
          "${aws_s3_bucket.hosting_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_acl" "review_app_s3_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.maintenance_bucket_oc,
    aws_s3_bucket_public_access_block.public_access
  ]

  bucket = aws_s3_bucket.hosting_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "hosting_bucket_website" {
  bucket = aws_s3_bucket.hosting_bucket.id
  
    index_document {
    suffix = "maintenance.html"
  }
}

resource "aws_s3_object" "maintenance_page" {
  bucket       = aws_s3_bucket.hosting_bucket.id
  key          = "maintenance.html"
  content_type = "text/html"
  source       = "${path.module}/html/maintenance.html"
}

