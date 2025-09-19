# Static Website on AWS S3 with CloudFront

A modern, responsive personal website hosted on AWS S3 with CloudFront CDN distribution.

## 🚀 Features

- **Static Website Hosting** on Amazon S3
- **Global CDN** with CloudFront distribution
- **HTTPS** enabled with automatic redirect
- **Custom Error Pages** (404 handling)
- **Origin Access Control (OAC)** for security
- **Contact Form** with modern UI
- **Responsive Design** with gradient backgrounds
- **Infrastructure as Code** using Terraform

## 🏗️ Architecture

- **S3 Bucket**: Stores website files (private access)
- **CloudFront**: Global CDN for fast content delivery
- **OAC**: Secure access from CloudFront to S3

## 📁 Project Structure
├── terraform/ # Infrastructure code
│ ├── main.tf # Main Terraform configuration
│ ├── variables.tf # Variable definitions
│ ├── outputs.tf # Output values
│ └── provider.tf # AWS provider configuration
├── website/ # Website files
│ ├── index.html # Main page
│ ├── about.html # About page
│ ├── error.html # 404 error page
│ └── assets/ # CSS, JS, images
├── scripts/ # Deployment scripts
│ ├── upload.sh # Upload files to S3
│ └── invalidate_cache.sh # CloudFront cache invalidation
└── docs/ # Documentation

## 🛠️ Prerequisites

- AWS CLI configured
- Terraform installed
- AWS account with appropriate permissions

## 🚀 Deployment

### 1. Configure Variables
```bash
cd terraform
cp terraform.tfvars.shishantkanojia-unique-bucket-name-12345
# Edit terraform.tfvars with your bucket name

## Deploy Infrastructure
terraform init
terraform plan
terraform apply

##Upload Website Files
aws s3 sync ../website/ s3://your-bucket-name/

# Get Check Website URL 
terraform output cloudfront_domain_name
