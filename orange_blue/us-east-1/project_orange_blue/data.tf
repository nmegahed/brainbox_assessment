locals {
  vpc_name             = "vpc-${terraform.workspace}"
  subnet_name_1        = "private-us-east-1e-${terraform.workspace}"
  subnet_name_2        = "private-us-east-1f-${terraform.workspace}"
}

data "aws_vpc" "private" {
  filter {
    name   = "tag:Name"
    values = [local.vpc_name]
  }
}

data "aws_subnet" "private-us-east-1e" {
  filter {
    name   = "tag:Name"
    values = [local.subnet_name_1]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.private.id]
  }
}

data "aws_subnet" "private-us-east-1f" {
  filter {
    name   = "tag:Name"
    values = [local.subnet_name_2]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.private.id]
  }
}

data "aws_ami" "ubuntu_2404" {
  most_recent = true
  owners      = ["483285841698"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu-2404-standard-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}














