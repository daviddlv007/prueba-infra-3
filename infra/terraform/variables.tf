variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "prueba-infra-3"
}

variable "instance_ami" {
  description = "AMI de la instancia EC2"
  type        = string
  default     = "ami-00ca32bbc84273381"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nombre del key pair"
  type        = string
  default     = "dev-key"
}