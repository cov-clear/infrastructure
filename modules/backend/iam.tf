resource "aws_iam_user" "backend" {
  name = var.app_name
}

resource "aws_iam_access_key" "backend" {
  user = aws_iam_user.backend.name
}


resource "aws_iam_user_policy" "send_emails" {
  name = "SendEmails"
  user = aws_iam_user.backend.name

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
