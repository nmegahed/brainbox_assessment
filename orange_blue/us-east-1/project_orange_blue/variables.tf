variable "aws_region" {
    type = string
    default = "us-east-1"
    description = "The AWS Region to be used for the provider"
}


variable "assume_role" {
    type = string
    default = ""
    description = "The AWS Role for AWS account that terraform can assume"
}
