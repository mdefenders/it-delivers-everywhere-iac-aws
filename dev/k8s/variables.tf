variable "k8s_version" {
  type        = string
  description = "Kubernetes version"
}

variable "min_pool_size" {
  type        = number
  description = "Minimum size of the node pool"
}
variable "max_pool_size" {
  type        = number
  description = "Maximum size of the node pool"
}

variable "desired_pool_size" {
  type        = number
  description = "Desired size of the node pool"
}

variable "logs_retantion_in_days" {
  type        = number
  description = "Number of days to retain logs in CloudWatch"
}
variable "ami_type" {
  type        = string
  description = "Type of AMI to use for the EKS nodes"
  default     = "BOTTLEROCKET_x86_64"
}
variable "instance_types" {
  type        = list(string)
  description = "List of instance types for the EKS nodes"
  default     = ["t3.small"]
}
variable "capacity_type" {
  type        = string
  description = "Capacity type for the EKS nodes"
  default     = "SPOT"
}
