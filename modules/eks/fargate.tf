resource "aws_iam_role" "fargate" {
  name = "${var.cluster_name}-fargate"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "eks-fargate-pods.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "fargate-AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate.name
}

resource "aws_eks_fargate_profile" "fargate_profile" {
  count = "${length(var.fargate_namespaces)}"

  cluster_name           = aws_eks_cluster.eks_cluster.name
  fargate_profile_name   = var.fargate_namespaces[count.index]
  pod_execution_role_arn = aws_iam_role.fargate.arn
  subnet_ids             = var.subnet_ids

  selector {
    namespace = var.fargate_namespaces[count.index]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.fargate-AmazonEKSFargatePodExecutionRolePolicy",
  ]
}
