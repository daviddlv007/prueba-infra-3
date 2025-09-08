module "ec2" {
  source        = "../../modules/ec2"
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  volume_size   = var.volume_size
  volume_type   = var.volume_type
  project_name  = var.project_name
}
