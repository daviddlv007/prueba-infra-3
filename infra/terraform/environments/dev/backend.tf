# infra/terraform/environments/dev/backend.tf
terraform {
  backend "s3" {
    encrypt = true
    region  = "us-east-1"
    # ↓ Los otros parámetros se inyectan via backend-config
  }
}