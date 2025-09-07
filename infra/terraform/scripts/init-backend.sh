# infra/terraform/scripts/init-backend.sh
#!/bin/bash
set -e

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
PROJECT_NAME=$(basename $(git rev-parse --show-toplevel))
ENVIRONMENT="dev"

terraform init -reconfigure \
  -backend-config="bucket=terraform-state-${ACCOUNT_ID}-${ENVIRONMENT}" \
  -backend-config="key=${PROJECT_NAME}/${ENVIRONMENT}/terraform.tfstate" \
  -backend-config="dynamodb_table=terraform-locks-${ACCOUNT_ID}" \
  -backend-config="region=us-east-1" \
  -backend-config="encrypt=true"