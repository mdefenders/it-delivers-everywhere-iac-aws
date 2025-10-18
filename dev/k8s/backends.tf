terraform {
  backend "s3" {
    bucket  = "adt-terraform-state-buckets"
    key     = "it-delivers-everywhere/dev/k8s/terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
  }
}

data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket  = "adt-terraform-state-buckets"
    key     = "it-delivers-everywhere/dev/infra/terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
  }
}
