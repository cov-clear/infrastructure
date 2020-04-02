resource "aws_iam_user" "developers" {
  count = length(var.developers)

  name = var.developers[count.index]
}

resource "aws_iam_user_group_membership" "developers" {
  count = length(var.developers)

  user = var.developers[count.index]

  groups = [
    aws_iam_group.developers.name,
  ]
}

