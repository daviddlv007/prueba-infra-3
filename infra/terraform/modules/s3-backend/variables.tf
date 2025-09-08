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

variable "lock_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
  default     = "terraform-state-lock"
}

variable "create_resources" {
  description = "Whether to create the backend resources or assume they exist"
  type        = bool
  default     = true
}