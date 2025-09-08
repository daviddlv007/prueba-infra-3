output "bucket_name" {
  description = "Name of the S3 bucket"
  value = var.import_existing ? var.bucket_name : (
    length(aws_s3_bucket.terraform_state) > 0 ? aws_s3_bucket.terraform_state[0].bucket : var.bucket_name
  )
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value = var.import_existing ? (
    length(data.aws_s3_bucket.existing) > 0 ? data.aws_s3_bucket.existing[0].arn : ""
  ) : (
    length(aws_s3_bucket.terraform_state) > 0 ? aws_s3_bucket.terraform_state[0].arn : ""
  )
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value = var.import_existing ? var.lock_table_name : (
    length(aws_dynamodb_table.terraform_state_lock) > 0 ? aws_dynamodb_table.terraform_state_lock[0].name : var.lock_table_name
  )
}

output "resources_need_import" {
  description = "Whether resources exist but need to be imported"
  value       = var.import_existing
}

output "bucket_exists" {
  description = "Whether the bucket exists"
  value = var.import_existing ? (
    length(data.aws_s3_bucket.existing) > 0 ? true : false
  ) : false
}