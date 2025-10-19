output "azs" {
  value = data.aws_availability_zones.available.names
}
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "aws_region" {
  value = var.aws_region
}
output "vpc_name" {
  value = var.vpc_name
}
output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "Private subnets IDs"
}
output "bastion_id" {
  value = module.infra.bastion_id
}
output "bastion_security_group" {
  value       = module.infra.bastion_security_group
  description = "Security group ID for the bastion host (null if not created)."
}
output "tags" {
  value       = var.tags
  description = "Deployment tags"
}
