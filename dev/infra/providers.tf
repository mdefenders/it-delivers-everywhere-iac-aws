terraform {
  required_version = ">= 1.12.2, < 1.14.0"
}

provider "aws" {
  region  = var.aws_region
}
