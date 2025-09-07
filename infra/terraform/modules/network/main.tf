data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "main" {
  name_prefix = "${var.name_prefix}-sg-"
  description = "Security group for ${var.name_prefix}"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-sg"
  })

  lifecycle {
    create_before_destroy = true
  }
}