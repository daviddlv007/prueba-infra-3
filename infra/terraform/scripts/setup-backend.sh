#!/bin/bash
set -e

# Obtener valores directamente
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
BUCKET_NAME="terraform-state-${ACCOUNT_ID}-dev"
TABLE_NAME="terraform-locks-${ACCOUNT_ID}"

echo "Setting up Terraform backend..."
echo "Account ID: ${ACCOUNT_ID}"
echo "S3 Bucket: ${BUCKET_NAME}"
echo "DynamoDB Table: ${TABLE_NAME}"

# Create S3 bucket
if ! aws s3api head-bucket --bucket "${BUCKET_NAME}" 2>/dev/null; then
  echo "Creating S3 bucket: ${BUCKET_NAME}"
  
  # us-east-1 requiere un tratamiento especial
  if [ "$AWS_REGION" = "us-east-1" ] || [ -z "$AWS_REGION" ]; then
    aws s3api create-bucket \
      --bucket "${BUCKET_NAME}" \
      --region us-east-1
  else
    aws s3api create-bucket \
      --bucket "${BUCKET_NAME}" \
      --region "${AWS_REGION}" \
      --create-bucket-configuration LocationConstraint="${AWS_REGION}"
  fi
  
  aws s3api put-bucket-versioning \
    --bucket "${BUCKET_NAME}" \
    --versioning-configuration Status=Enabled
  
  aws s3api put-bucket-encryption \
    --bucket "${BUCKET_NAME}" \
    --server-side-encryption-configuration '{
      "Rules": [{
        "ApplyServerSideEncryptionByDefault": {
          "SSEAlgorithm": "AES256"
        }
      }]
    }'
  
  echo "✅ S3 bucket created successfully: ${BUCKET_NAME}"
else
  echo "✅ S3 bucket already exists: ${BUCKET_NAME}"
fi

# Create DynamoDB table
if ! aws dynamodb describe-table --table-name "${TABLE_NAME}" 2>/dev/null; then
  echo "Creating DynamoDB table: ${TABLE_NAME}"
  aws dynamodb create-table \
    --table-name "${TABLE_NAME}" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region us-east-1
  
  echo "✅ DynamoDB table created successfully: ${TABLE_NAME}"
else
  echo "✅ DynamoDB table already exists: ${TABLE_NAME}"
fi

echo "🎉 Backend setup complete!"
echo "S3 Bucket: ${BUCKET_NAME}"
echo "DynamoDB Table: ${TABLE_NAME}"