output "machine_users" {
  value = {
    for user in aws_iam_user.cd :
    user.name => {
      arn : user.arn,
      access_key : aws_iam_access_key.cd[user.name].id,
      secret_key : aws_iam_access_key.cd[user.name].secret
    }
  }
}
