output "instance_id" {
  description = "Instance ID"
  value       = aws_instance.main.id
}

output "public_ip" {
  description = "Public IP address"
  value       = aws_instance.main.public_ip
}

output "public_dns" {
  description = "Public DNS name"
  value       = aws_instance.main.public_dns
}