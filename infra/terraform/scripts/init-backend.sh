#!/bin/bash
set -e

# Obtener valores dinámicamente
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
PROJECT_NAME=$(basename $(git rev-parse --show-toplevel))
ENVIRONMENT="dev"

echo "Initializing Terraform backend for:"
echo "Project: ${PROJECT_NAME}"
echo "Environment: ${ENVIRONMENT}"
echo "Account ID: ${ACCOUNT_ID}"

# Cambiar al directorio de Terraform
cd ./infra/terraform/environments/dev

# Inicializar Terraform con configuración dinámica del backend
terraform init -reconfigure -input=false \
  -backend-config="bucket=terraform-state-${ACCOUNT_ID}-${ENVIRONMENT}" \
  -backend-config="key=${PROJECT_NAME}/${ENVIRONMENT}/terraform.tfstate" \
  -backend-config="dynamodb_table=terraform-locks-${ACCOUNT_ID}" \
  -backend-config="region=us-east-1" \
  -backend-config="encrypt=true"

# Forzar la instalación de módulos (esto asegura que los módulos se instalen)
echo "Ensuring all modules are installed..."
terraform get -update

echo "✅ Terraform backend initialized successfully!"
echo "✅ All modules installed successfully!"