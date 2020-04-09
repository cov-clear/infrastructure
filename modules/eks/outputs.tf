output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig_certificate" {
  value = aws_eks_cluster.eks_cluster.certificate_authority.0.data
}
