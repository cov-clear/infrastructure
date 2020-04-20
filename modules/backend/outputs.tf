output "access_key" {
  value = aws_iam_access_key.backend.id
}

output "secret_key" {
  value     = aws_iam_access_key.backend.secret
  sensitive = true
}

