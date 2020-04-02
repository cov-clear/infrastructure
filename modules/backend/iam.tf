resource "aws_iam_user" "backend" {
  name = var.app_name
}

resource "aws_iam_access_key" "backend" {
  user = aws_iam_user.backend.name
}


resource "aws_iam_user_policy" "send_emails" {
  name = "SendEmails"
  user = aws_iam_user.backend.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ses:SendEmail",
        "ses:SendRawEmail"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
