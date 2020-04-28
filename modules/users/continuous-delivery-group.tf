resource "aws_iam_group" "cd" {
  name = "continuous-delivery"
}

resource "aws_iam_group_policy" "eks" {
  name  = "eks-read-access"
  group = aws_iam_group.cd.name

  policy = jsonencode({
    Statement = [{
      Action = [
        "eks:DescribeCluster",
        "eks:ListClusters"
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}
