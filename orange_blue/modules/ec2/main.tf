resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [ aws_security_group.this.id ]
  key_name               = var.key_name

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.volume_type
    delete_on_termination = true
  }

  tags = merge(
    {
      Name = var.instance_name
    },
    var.tags
  )
}
resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description      = ingress.value.description
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
      security_groups  = ingress.value.security_groups
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description      = egress.value.description
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = egress.value.cidr_blocks
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
      security_groups  = egress.value.security_groups
    }
  }

  tags = var.tags
}