#!/bin/bash
set -e

# Configuración dinámica basada en variables de entorno
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION=${AWS_REGION:-us-east-1}
ENVIRONMENT=${ENVIRONMENT:-dev}
PROJECT_NAME=${PROJECT_NAME:-$(basename $(git rev-parse --show-toplevel))}

BUCKET_NAME="terraform-state-${ACCOUNT_ID}-${ENVIRONMENT}"
TABLE_NAME="terraform-locks-${ACCOUNT_ID}"

echo "Setting up Terraform backend for ${PROJECT_NAME} (${ENVIRONMENT})..."
echo "Account ID: ${ACCOUNT_ID}"
echo "Region: ${REGION}"

# Create S3 bucket
if ! aws s3api head-bucket --bucket "${BUCKET_NAME}" 2>/dev/null; then
  echo "Creating S3 bucket: ${BUCKET_NAME}"
  
  # us-east-1 requiere un tratamiento especial
  if [ "$REGION" = "us-east-1" ]; then
    aws s3api create-bucket \
      --bucket "${BUCKET_NAME}" \
      --region "${REGION}"
  else
    aws s3api create-bucket \
      --bucket "${BUCKET_NAME}" \
      --region "${REGION}" \
      --create-bucket-configuration LocationConstraint="${REGION}"
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
  
  echo "S3 bucket created successfully: ${BUCKET_NAME}"
else
  echo "S3 bucket already exists: ${BUCKET_NAME}"
fi

# Create DynamoDB table
if ! aws dynamodb describe-table --table-name "${TABLE_NAME}" 2>/dev/null; then
  echo "Creating DynamoDB table: ${TABLE_NAME}"
  aws dynamodb create-table \
    --table-name "${TABLE_NAME}" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region "${REGION}"
  
  echo "DynamoDB table created successfully: ${TABLE_NAME}"
else
  echo "DynamoDB table already exists: ${TABLE_NAME}"
fi

echo "Backend setup complete!"
echo "S3 Bucket: ${BUCKET_NAME}"
echo "DynamoDB Table: ${TABLE_NAME}"