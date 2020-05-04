output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
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
