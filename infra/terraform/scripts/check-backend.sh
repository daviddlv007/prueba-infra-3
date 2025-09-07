#!/bin/bash
set -e

# Configuración dinámica
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ENVIRONMENT=${ENVIRONMENT:-dev}
BUCKET_NAME="terraform-state-${ACCOUNT_ID}-${ENVIRONMENT}"
TABLE_NAME="terraform-locks-${ACCOUNT_ID}"

# Verificar bucket S3
if aws s3api head-bucket --bucket "${BUCKET_NAME}" 2>/dev/null; then
    echo "S3 bucket exists: ${BUCKET_NAME}"
    S3_EXISTS=true
else
    echo "S3 bucket does not exist: ${BUCKET_NAME}"
    S3_EXISTS=false
fi

# Verificar tabla DynamoDB
if aws dynamodb describe-table --table-name "${TABLE_NAME}" 2>/dev/null; then
    echo "DynamoDB table exists: ${TABLE_NAME}"
    DYNAMO_EXISTS=true
else
    echo "DynamoDB table does not exist: ${TABLE_NAME}"
    DYNAMO_EXISTS=false
fi

# Devolver código de salida
if [ "$S3_EXISTS" = true ] && [ "$DYNAMO_EXISTS" = true ]; then
    echo "Backend resources are ready"
    exit 0
else
    echo "Backend resources are missing"
    exit 1
fi