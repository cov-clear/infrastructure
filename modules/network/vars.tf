variable "short_name" {
  description = "Project short name, to use in resource labels"
}

variable "aws_region" {
  description = "Region where the VPC will be created"
}

variable "cidr" {
  description = "CIDR for the VPC"
}

variable "public_subnets" {
  description = "Public subnets definition"
  type = list(object({
    availability_zone = string
    cidr              = string
  }))
}

variable "private_subnets" {
  description = "Private subnets definition"
  type = list(object({
    availability_zone = string
    cidr              = string
  }))
}
