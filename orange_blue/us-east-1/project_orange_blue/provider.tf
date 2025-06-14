
locals {
  assume_role_arns = {
    dev  = "arn:aws:iam::111111111111:role/TerraformExecutionRole"
    test = "arn:aws:iam::222222222222:role/TerraformExecutionRole"
    prod = "arn:aws:iam::333333333333:role/TerraformExecutionRole"
  }
  role_to_assume = local.assume_role_arns[terraform.]
}


provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn     = local.role_to_assume
    session_name = "terraform-${terraform.workspace}"
  }
}
