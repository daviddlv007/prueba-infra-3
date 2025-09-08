provider "aws" {
  region = var.aws_region
}

# Crear el bucket S3 para el estado de Terraform (si no existe)
resource "aws_s3_bucket" "terraform_state" {
  bucket = "prueba-infra-3-dev-7f3a2c"
  
  lifecycle {
    prevent_destroy = false
  }
  
  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Dev"
  }
}

# Configurar versionado para el bucket S3
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# Crear instancia EC2
resource "aws_instance" "app_server" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.key_name

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-server"
  }
}