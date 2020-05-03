resource "aws_iam_group" "developers" {
  name = "developers"
}

resource "aws_iam_group_policy_attachment" "ses_ro_access" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSESReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "sns_ro_access" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "ec2_ro_access" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "rds_ro_access" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "cloudwatch_ro_access" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "iam_ro_access" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

resource "aws_iam_group_policy" "eks_ro_access" {
  name  = "EKSReadOnlyAccess"
  group = aws_iam_group.developers.name

  policy = jsonencode({
    Statement = [{
      Action = [
        "eks:DescribeCluster",
        "eks:ListClusters",
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_group_policy" "change_password" {
  name  = "ChangeSelfPassword"
  group = aws_iam_group.developers.name

  policy = jsonencode({
    Statement = [{
      Action   = "iam:GetAccountPasswordPolicy"
      Effect   = "Allow"
      Resource = "*"
      }, {
      Action = [
        "iam:GetLoginProfile",
        "iam:ChangePassword"
      ]
      Effect   = "Allow"
      Resource = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/&{aws:username}"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_group_policy" "manage_access_keys" {
  name  = "ManageSelfAccessKeys"
  group = aws_iam_group.developers.name

  policy = jsonencode({
    Statement = [{
      Action   = "iam:ListUsers"
      Effect   = "Allow"
      Resource = "*"
      }, {
      Action = [
        "iam:DeleteAccessKey",
        "iam:GetAccessKeyLastUsed",
        "iam:UpdateAccessKey",
        "iam:GetUser",
        "iam:CreateAccessKey",
        "iam:ListAccessKeys",
      ]
      Effect   = "Allow"
      Resource = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/&{aws:username}"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_group_policy" "manage_2fa" {
  name  = "ManageSelf2FactorDevices"
  group = aws_iam_group.developers.name

  policy = jsonencode({
    Statement = [{
      Action = [
        "iam:ListMFADevices",
        "iam:ListVirtualMFADevices",
        "iam:ListUsers"
      ]
      Effect   = "Allow"
      Resource = "*"
      }, {
      Action = [
        "iam:CreateVirtualMFADevice",
        "iam:EnableMFADevice",
        "iam:ResyncMFADevice",
        "iam:DeleteVirtualMFADevice",
      ]
      Effect = "Allow"
      Resource = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:mfa/&{aws:username}",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/&{aws:username}",

      ]
      }, {
      Action = [
        "iam:DeactivateMFADevice",
      ]
      Effect = "Allow"
      Resource = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:mfa/&{aws:username}",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/&{aws:username}",

      ]
      Condition = {
        Bool = {
          "aws:MultiFactorAuthPresent" : "false"
        }
      }
    }]
    Version = "2012-10-17"
  })
}
