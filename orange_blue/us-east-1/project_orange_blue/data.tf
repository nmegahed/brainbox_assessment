data "aws_vpc" "private" {
  filter {
    name   = "tag:Name"
    values = ["test"]
  }
}

data "aws_subnet" "private-us-east-1f" {
  filter {
    name   = "tag:Name"
    values = ["private-us-east-1f"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.private.id]
  }
}

data "aws_subnet" "private-us-east-1e" {
  filter {
    name   = "tag:Name"
    values = ["private-us-east-1e"]
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
