#!/bin/bash
set -e

echo "=== Starting Terraform Initialization ==="
echo "Current directory: $(pwd)"

# Obtener valores dinámicamente
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
PROJECT_NAME=$(basename $(git rev-parse --show-toplevel))
ENVIRONMENT="dev"

echo "Project: ${PROJECT_NAME}"
echo "Environment: ${ENVIRONMENT}"
echo "Account ID: ${ACCOUNT_ID}"

# Cambiar al directorio de Terraform - CORREGIR RUTA
echo "Changing to Terraform directory..."
cd ./infra/terraform/environments/dev
echo "Now in directory: $(pwd)"

# Verificar que estamos en el directorio correcto
if [ ! -f "main.tf" ]; then
    echo "❌ ERROR: main.tf not found in current directory!"
    echo "Directory contents:"
    ls -la
    exit 1
fi

# Inicializar Terraform con configuración dinámica del backend
echo "Initializing Terraform backend..."
terraform init -reconfigure -input=false \
  -backend-config="bucket=terraform-state-${ACCOUNT_ID}-${ENVIRONMENT}" \
  -backend-config="key=${PROJECT_NAME}/${ENVIRONMENT}/terraform.tfstate" \
  -backend-config="dynamodb_table=terraform-locks-${ACCOUNT_ID}" \
  -backend-config="region=us-east-1" \
  -backend-config="encrypt=true"

# Forzar la instalación de módulos
echo "Installing modules..."
terraform get -update

# Forzar la instalación de providers
echo "Ensuring providers are installed..."
terraform init -upgrade

# Verificar que todo está instalado
echo "Verifying installation..."
terraform version
terraform providers

echo "✅ Terraform backend initialized successfully!"
echo "✅ All modules installed successfully!"
echo "✅ All providers installed successfully!"