output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Dirección IP pública de la instancia EC2"
  value       = aws_instance.app_server.public_ip
}

output "s3_bucket_name" {
  description = "Nombre del bucket S3 para el estado de Terraform"
  value       = aws_s3_bucket.terraform_state.bucket
}