project_name  = "prueba-infra-3"
environment   = "dev"

# Configuración de red
vpc_cidr      = "10.0.0.0/16"

# Configuración de instancia EC2
instance_ami  = "ami-00ca32bbc84273381"
instance_type = "t2.micro"
key_name      = "dev-key"
volume_size   = 8
volume_type   = "gp3"