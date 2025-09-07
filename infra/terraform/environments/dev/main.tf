data "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-${local.account_id}-dev"
}

data "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-locks-${local.account_id}"
}

module "network" {
  source = "../../modules/network"

  name_prefix = "${var.project_name}-dev"
  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  tags = {
    Environment = "dev"
    Project     = var.project_name
  }
}

module "compute" {
  source = "../../modules/compute"

  name              = "${var.project_name}-dev"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  security_group_id = module.network.security_group_id
  volume_size       = var.volume_size
  volume_type       = var.volume_type
  tags = {
    Environment = "dev"
    Project     = var.project_name
  }
}

data "aws_caller_identity" "current" {}