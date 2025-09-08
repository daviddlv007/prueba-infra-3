variable "project_name" {
  type    = string
  default = "prueba-infra-3"
}

variable "ami" {
  type    = string
  default = "ami-00ca32bbc84273381"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "dev-key"
}

variable "volume_size" {
  type    = number
  default = 8
}

variable "volume_type" {
  type    = string
  default = "gp3"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "backend_bucket" {
  type = string
}

variable "backend_table" {
  type = string
}
