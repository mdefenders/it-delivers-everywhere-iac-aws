output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
output "cluster_certificate_authority_data" {
  value     = module.eks.cluster_certificate_authority_data
  sensitive = true
}
output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_autoscaler_irsa_role" {
  description = "IAM Role ARN for Cluster Autoscaler Service Account"
  value       = module.cluster_autoscaler_irsa_role.arn
}
