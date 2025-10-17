data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.4.0"

  name = var.vpc_name
  cidr = var.vpc_cidr


  azs             = data.aws_availability_zones.available.names
  private_subnets = [for k, v in data.aws_availability_zones.available.names : cidrsubnet(var.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in data.aws_availability_zones.available.names : cidrsubnet(var.vpc_cidr, 8, k + 48)]
  intra_subnets   = [for k, v in data.aws_availability_zones.available.names : cidrsubnet(var.vpc_cidr, 8, k + 52)]

  enable_nat_gateway      = true
  single_nat_gateway      = true
  map_public_ip_on_launch = false
  # enable_dns_hostnames = true


  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = var.tags
}

module "infra" {
  source                = "git::https://github.com/mdefenders/terraform-aws-infra.git?ref=v1.0.0"
  vpc_name              = var.vpc_name
  tags                  = var.tags
  bastion_enabled       = var.bastion_enabled
  bastion_instance_type = var.bastion_instance_type
  bastion_ami_id        = var.bastion_ami_id
  vpc_id                = module.vpc.vpc_id
  bastion_subnet_id     = module.vpc.private_subnets[0]
}
