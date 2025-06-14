module "orange_instances" {
  source   = "../../modules/ec2"
  for_each = { for inst in local.oranges : inst.name => inst }
  ami_id            = each.value.ami_id
  name              = each.value.sg_name
  instance_type     = each.value.instance_type
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  key_name          = each.value.key_name
  instance_name     = each.value.name
  root_volume_size  = each.value.root_volume_size
  ingress_rules = [
    {
      description      = "SSH from blue"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      security_groups  = [ module.blue_instances[local.orange_to_blue_map[each.key]].security_group_id] 
    }
  ]
  egress_rules = [
        {
          description      = "Allow all"
          from_port        = 0
          to_port          = 0
          protocol         = "-1"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = []
          security_groups  = []
        }
      ]
  tags              = each.value.tags
}

module "blue_instances" {
  source   = "../../modules/ec2"
  for_each = { for inst in local.blues : inst.name => inst }
  ami_id            = each.value.ami_id
  instance_type     = each.value.instance_type
  name              = each.value.sg_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  key_name          = each.value.key_name
  instance_name     = each.value.name
  root_volume_size  = each.value.root_volume_size
  ingress_rules = [
      ]
   egress_rules = [
        {
          description      = "Allow all"
          from_port        = 0
          to_port          = 0
          protocol         = "-1"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = []
          security_groups  = []
        }
      ]
  tags              = each.value.tags
}


 locals {

  oranges = [
    {
      name             = "${terraform.workspace}-orange-web-1"
      ami_id           = data.aws_ami.ubuntu_2404.id
      instance_type    = t3.micro
      subnet_id        = data.aws_subnet.private-us-east-1f.id
      vpc_id           = data.aws_vpc.private.id
      key_name         = "${terraform.space}-key"
      sg_name          = "oranges_sg"
      root_volume_size = 20
      tags = {
        Environment = "${terraform.workspace}"
        Owner       = "orange"
      }
    }
  ]

  blues = [
    {
      name             = "${terraform.workspace}-blue-db-1"
      ami_id           = data.aws_ami.ubuntu_2404.id
      instance_type    = "t3.small"
      subnet_id        = data.aws_subnet.private-us-east-1f.id
      vpc_id           = data.aws_vpc.private.id
      key_name         = "my-key"
      sg_name          = "blues-sg"
      root_volume_size = 50
      tags = {
        Environment = "${terraform.workspace}"
        Owner       = "blue"
      }
    }
  ]
  orange_to_blue_map = {
    "orange-web-1" = "blue-db-1"
    "orange-web-2" = "blue-db-2"
  }
}
