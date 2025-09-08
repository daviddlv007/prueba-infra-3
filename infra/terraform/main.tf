terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = var.backend_bucket      # Será pasado desde workflow
    key            = "terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = var.backend_table
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
