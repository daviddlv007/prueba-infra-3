#!/bin/bash
set -e

# Debug info
echo "=== Starting Terraform initialization ==="
echo "Working directory: $(pwd)"

# Obtener valores dinámicamente
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
PROJECT_NAME=$(basename $(git rev-parse --show-toplevel))
ENVIRONMENT="dev"

echo "Initializing Terraform backend for:"
echo "Project: ${PROJECT_NAME}"
echo "Environment: ${ENVIRONMENT}" 
echo "Account ID: ${ACCOUNT_ID}"

# Verificar que estamos en el directorio correcto
if [ ! -f "main.tf" ]; then
    echo "Changing to Terraform directory..."
    cd ./infra/terraform/environments/dev
fi

# Inicializar Terraform con configuración dinámica
terraform init -reconfigure -input=false \
  -backend-config="bucket=terraform-state-${ACCOUNT_ID}-${ENVIRONMENT}" \
  -backend-config="key=${PROJECT_NAME}/${ENVIRONMENT}/terraform.tfstate" \
  -backend-config="dynamodb_table=terraform-locks-${ACCOUNT_ID}" \
  -backend-config="region=us-east-1" \
  -backend-config="encrypt=true"

echo "✅ Terraform backend initialized successfully!"