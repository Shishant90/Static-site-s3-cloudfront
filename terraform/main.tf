# S3 bucket for static website
resource "aws_s3_bucket" "website" {
bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "website" {
bucket = aws_s3_bucket.website.id

block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true
}

resource "aws_s3_bucket_website_configuration" "website" {
bucket = aws_s3_bucket.website.id

index_document {
    suffix = "index.html"
}

error_document {
    key = "error.html"
}
}

# CloudFront Origin Access Control
resource "aws_cloudfront_origin_access_control" "website" {
name                              = "${var.bucket_name}-oac"
description                       = "OAC for ${var.bucket_name}"
origin_access_control_origin_type = "s3"
signing_behavior                  = "always"
signing_protocol                  = "sigv4"
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "website" {
origin {
    domain_name              = aws_s3_bucket.website.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.website.id
    origin_id                = "S3-${var.bucket_name}"
}

enabled             = true
is_ipv6_enabled     = true
default_root_object = "index.html"

default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${var.bucket_name}"
    compress               = true
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
    query_string = false
    cookies {
        forward = "none"
    }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
}

custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/error.html"
}

restrictions {
    geo_restriction {
    restriction_type = "none"
    }
}

viewer_certificate {
    cloudfront_default_certificate = true
}
}

# S3 bucket policy for CloudFront OAC
resource "aws_s3_bucket_policy" "cloudfront" {
bucket = aws_s3_bucket.website.id

policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
    {
        Sid    = "AllowCloudFrontServicePrincipal"
        Effect = "Allow"
        Principal = {
            Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.website.arn}/*"
        Condition = {
        StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.website.arn
        }
        }
    }
    ]
}
)

depends_on = [aws_s3_bucket_public_access_block.website]
}
