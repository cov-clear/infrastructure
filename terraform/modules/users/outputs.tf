output "admins" {
  value = {
    for user in aws_iam_user.admins :
    user.name => {
      arn : user.arn,
    }
  }
}

output "developers" {
  value = {
    for user in aws_iam_user.developers :
    user.name => {
      arn : user.arn,
    }
  }
}

output "continuous_delivery_bots" {
  value = {
    for user in aws_iam_user.cd :
    user.name => {
      arn : user.arn,
      access_key : aws_iam_access_key.cd[user.name].id,
      secret_key : aws_iam_access_key.cd[user.name].secret
    }
  }
}
