variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
}

variable "region" {
  description = "AWS region where the bucket will be created"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}