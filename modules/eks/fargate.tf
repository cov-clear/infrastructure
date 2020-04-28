resource "aws_iam_role" "fargate" {
  name = "${var.cluster_name}-fargate"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "fargate-AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate.name
}

resource "aws_eks_fargate_profile" "fargate_profile" {
  for_each = var.fargate_namespaces

  cluster_name           = aws_eks_cluster.eks_cluster.name
  fargate_profile_name   = each.key
  pod_execution_role_arn = aws_iam_role.fargate.arn
  subnet_ids             = each.value.subnet_ids

  selector {
    namespace = each.key
  }

  depends_on = [
    aws_iam_role_policy_attachment.fargate-AmazonEKSFargatePodExecutionRolePolicy,
  ]
}
