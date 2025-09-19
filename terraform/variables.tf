variable "aws_region" {
description = "AWS region"
type        = string

}

variable "bucket_name" {
description = "S3 bucket name for static website"
type        = string
}

variable "domain_name" {
description = "Domain name for the website"
type        = string
default     = ""
}
