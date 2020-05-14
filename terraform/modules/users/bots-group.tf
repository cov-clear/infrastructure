resource "aws_iam_group" "cd" {
  name = "continuous-delivery-bots"
}

resource "aws_iam_group_policy" "eks" {
  name  = "EKSReadOnlyAccess"
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
