output "bucket_name" {
description = "Name of the S3 bucket"
value       = aws_s3_bucket.website.bucket
}

output "website_endpoint" {
description = "Website endpoint"
value       = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "cloudfront_domain_name" {
description = "CloudFront distribution domain name"
value       = aws_cloudfront_distribution.website.domain_name
}

output "cloudfront_distribution_id" {
description = "CloudFront distribution ID"
value       = aws_cloudfront_distribution.website.id
}
