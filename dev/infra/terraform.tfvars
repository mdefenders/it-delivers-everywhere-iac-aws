vpc_name   = "it-delivers-dev"
vpc_cidr   = "10.0.0.0/16"
aws_region = "eu-north-1"
tags = {
  "Environment" = "dev"
  "Owner"       = "team"
  "Project"     = "it-delivers"
}

# Bastion host configuration
bastion_ami_id         = "null"       # (optional override)
bastion_enabled        = true       # (optional override)
bastion_instance_type  = "t3.micro" # (optional override)
