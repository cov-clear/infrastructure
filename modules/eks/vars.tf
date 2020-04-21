variable "aws_region" {
  description = "Region where the EKS cluster lives"
}

variable "cluster_name" {
  description = "Name of the EKS cluster and all its policies"
}

variable "subnet_ids" {
  description = "IDs of the subnets where the cluster will be available"
  type        = list(string)
}

variable "fargate_namespaces" {
  description = "Namespaces that EKS will manage inside of fargate"
  type        = list(string)
}

variable "public_access" {
  description = "Allow public access from internet to the control plane"
  default     = false
}
