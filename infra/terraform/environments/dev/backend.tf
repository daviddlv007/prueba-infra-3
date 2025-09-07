terraform {
  backend "s3" {
    bucket         = "terraform-state-${data.aws_caller_identity.current.account_id}-dev"
    key            = "prueba-infra-3/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks-${data.aws_caller_identity.current.account_id}"
  }
}