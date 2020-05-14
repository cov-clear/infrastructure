variable "admins" {
  description = "Map with the admin that will have access to the cluster"
  type        = map(map(string))
  default     = {}
}

variable "aws_region" {
  description = "Region where the EKS cluster lives"
}

variable "cluster_name" {
  description = "Name of the EKS cluster and all its policies"
}

variable "continuous_delivery_bots" {
  description = "Map with the bots that will have access to the cluster"
  type        = map(map(string))
  default     = {}
}

variable "developers" {
  description = "Map with the developers that will have access to the cluster"
  type        = map(map(string))
  default     = {}
}

variable "subnet_ids" {
  description = "IDs of the subnets where the cluster will be available"
  type        = list(string)
}

variable "fargate_namespaces" {
  description = "Namespaces that EKS will manage inside of fargate"
  type        = map(map(list(string)))
}

variable "public_access" {
  description = "Allow public access from internet to the control plane"
  default     = false
}
