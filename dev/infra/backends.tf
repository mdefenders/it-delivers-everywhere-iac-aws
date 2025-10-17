terraform {
  backend "s3" {
    bucket         = "adt-terraform-state-buckets"
    key            = "it-delivers-everywhere/dev/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }
}