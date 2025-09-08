# Data source para verificar si el bucket ya existe
data "aws_s3_bucket" "existing" {
  count  = var.import_existing ? 1 : 0
  bucket = var.bucket_name
}

# Data source para verificar si la tabla DynamoDB ya existe
data "aws_dynamodb_table" "existing" {
  count = var.import_existing ? 1 : 0
  name  = var.lock_table_name
}

# Recurso condicional para el bucket S3 (solo si no estamos importando)
resource "aws_s3_bucket" "terraform_state" {
  count  = var.import_existing ? 0 : 1
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Dev"
    Project     = var.project_name
  }
}

# Configuraciones del bucket S3 (solo si no estamos importando)
resource "aws_s3_bucket_versioning" "terraform_state" {
  count  = var.import_existing ? 0 : 1
  bucket = aws_s3_bucket.terraform_state[0].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  count  = var.import_existing ? 0 : 1
  bucket = aws_s3_bucket.terraform_state[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  count  = var.import_existing ? 0 : 1
  bucket = aws_s3_bucket.terraform_state[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Recurso condicional para la tabla DynamoDB (solo si no estamos importando)
resource "aws_dynamodb_table" "terraform_state_lock" {
  count        = var.import_existing ? 0 : 1
  name         = var.lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock Table"
    Environment = "Dev"
    Project     = var.project_name
  }
}