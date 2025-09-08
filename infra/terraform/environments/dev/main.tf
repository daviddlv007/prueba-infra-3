module "network" {
  source = "../../modules/network"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
}

module "compute" {
  source = "../../modules/compute"

  project_name      = var.project_name
  environment       = var.environment
  public_subnets    = module.network.public_subnets
  security_group_id = module.network.security_group_id
  instance_ami      = var.instance_ami
  instance_type     = var.instance_type
  key_name          = var.key_name
  volume_size       = var.volume_size
  volume_type       = var.volume_type
}