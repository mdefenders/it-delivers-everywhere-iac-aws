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
