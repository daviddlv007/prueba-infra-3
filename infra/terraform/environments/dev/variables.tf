variable "project_name" {
  description = "Project name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-00ca32bbc84273381"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "volume_size" {
  description = "Root volume size"
  type        = number
  default     = 8
}

variable "volume_type" {
  description = "Root volume type"
  type        = string
  default     = "gp3"
}