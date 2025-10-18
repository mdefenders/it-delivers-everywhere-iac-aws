locals {

  vpc_name   = data.terraform_remote_state.infra.outputs.vpc_name
  bastion_sg = data.terraform_remote_state.infra.outputs.bastion_security_group
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.4.0"

  compute_config = {
    enabled = false
  }

  name               = "${local.vpc_name}-eks"
  kubernetes_version = var.k8s_version

  # not for prod:
  deletion_protection    = false
  endpoint_public_access = false
  security_group_additional_rules = {
    allow_https_from_bastion = {
      description              = "Allow HTTPS from Bastion"
      protocol                 = "tcp"
      from_port                = 443
      to_port                  = 443
      type                     = "ingress"
      source_security_group_id = data.terraform_remote_state.infra.outputs.bastion_security_group
    }
  }
  enable_cluster_creator_admin_permissions = true
  authentication_mode                      = "API_AND_CONFIG_MAP"

  cloudwatch_log_group_retention_in_days = var.logs_retantion_in_days

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  vpc_id     = data.terraform_remote_state.infra.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.infra.outputs.private_subnets

  eks_managed_node_groups = {
    "${local.vpc_name}" = {
      ami_type       = var.ami_type
      instance_types = var.instance_types
      capacity_type  = var.capacity_type

      min_size = var.min_pool_size
      max_size = var.max_pool_size
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = var.desired_pool_size

      # This is not required - demonstrates how to pass additional configuration
      # Ref https://bottlerocket.dev/en/os/1.19.x/api/settings/
      bootstrap_extra_args = <<-EOT
        # The admin host container provides SSH access and runs with "superpowers".
        # It is disabled by default, but can be disabled explicitly.
        [settings.host-containers.admin]
        enabled = false

        # The control host container provides out-of-band access via SSM.
        # It is enabled by default, and can be disabled if you do not expect to use SSM.
        # This could leave you with no way to access the API and change settings on an existing node!
        [settings.host-containers.control]
        enabled = true

        # extra args added
        [settings.kernel]
        lockdown = "integrity"
      EOT
    }
  }
}
