terraform {
  required_providers {
    aws = {
      source  = "HASHICORP/AWS"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"

  backend "s3" {
    bucket  = "terraform-test-blue-orange"
    key     = "envs/${terraform.workspace}/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

