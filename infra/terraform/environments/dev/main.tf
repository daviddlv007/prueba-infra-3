module "backend" {
  source = "../../modules/backend"

  bucket_name      = "terraform-state-${data.aws_caller_identity.current.account_id}-dev"
  lock_table_name  = "terraform-locks-${data.aws_caller_identity.current.account_id}"
  tags = {
    Environment = "dev"
    Project     = var.project_name
  }
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

  name               = "${var.project_name}-dev"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  security_group_id  = module.network.security_group_id
  volume_size        = var.volume_size
  volume_type        = var.volume_type
  tags = {
    Environment = "dev"
    Project     = var.project_name
  }
}

data "aws_caller_identity" "current" {}