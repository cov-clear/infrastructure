variable "app_name" {
  description = "Name of the app, must be unique in the AWS account"
}

variable "domain_name" {
  description = "Domain where the app is hosted"
}

variable "namespace" {
  description = "Kubernetes namespace where the app will run"
}

variable "iam_oidc_arn" {
  description = "ARN of the OIDC provider that will give permissions to the backend to access ARN resources"
}

variable "iam_oidc_provider" {
  description = "String identifying the OIDC provider that will give permissions to the backend to access ARN resources"
}
