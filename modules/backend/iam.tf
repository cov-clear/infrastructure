resource "aws_iam_role" "backend" {
  name = "${var.app_name}-backend"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {
        Federated = var.iam_oidc_arn
      }
      Condition = {
        StringEquals = {
          "${var.iam_oidc_provider}" = "system:serviceaccount:${var.namespace}:backend"
        }
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy" "send_emails" {
  name = "SendEmails"
  role = aws_iam_role.backend.name

  policy = jsonencode({
    Statement = [{
      Action = [
        "ses:SendEmail",
        "ses:SendRawEmail"
      ],
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}
