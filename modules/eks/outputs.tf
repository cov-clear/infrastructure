output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig_certificate" {
  value = aws_eks_cluster.eks_cluster.certificate_authority.0.data
}

output "alb_role_arn" {
  value = aws_iam_role.alb.arn
}

output "iam_oidc_arn" {
  value = aws_iam_openid_connect_provider.main.arn
}

output "iam_oidc_provider" {
  value = "${replace(aws_iam_openid_connect_provider.main.url, "https://", "")}:sub"
}
