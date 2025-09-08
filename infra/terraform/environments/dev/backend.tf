terraform {
  backend "s3" {
    bucket         = "prueba-infra-3-dev-7f3a2c"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
