terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }

  backend "s3" {
    bucket         = "REPLACE_ME_BUCKET"       # Se reemplaza con -backend-config
    key            = "terraform.tfstate"
    region         = "us-east-1"              # Se reemplaza con -backend-config
    dynamodb_table = "REPLACE_ME_TABLE"       # Se reemplaza con -backend-config
    encrypt        = true
  }
  
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = "${var.project_name}-ec2"
  }
}


