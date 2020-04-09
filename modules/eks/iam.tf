resource "aws_iam_role" "eks" {
  name = "${var.cluster_name}-eks"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy" "service_linked" {
  name = "${var.cluster_name}-service-linked"
  role = aws_iam_role.eks.name

  policy = jsonencode({
    Statement = [{
      Action   = "iam:CreateServiceLinkedRole"
      Effect   = "Allow"
      Resource = "arn:aws:iam::*:role/aws-service-role/*"
      }, {
      Action   = "ec2:DescribeAccountAttributes"
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks.name
}
