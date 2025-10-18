terraform {
  backend "s3" {
    bucket         = "adt-terraform-state-buckets"
    key            = "it-delivers-everywhere/dev/infra/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }
}