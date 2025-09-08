terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {

  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "prueba-infra-3"
      Environment = "dev"
      Terraform   = "true"
    }
  }
}