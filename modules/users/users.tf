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

resource "aws_iam_user" "cd" {
  for_each = var.machines

  name = each.key
}

resource "aws_iam_user_group_membership" "cd" {
  for_each = var.machines

  user   = each.key
  groups = each.value

  depends_on = [
    aws_iam_user.cd,
  ]
}

resource "aws_iam_access_key" "cd" {
  for_each = var.machines

  user = each.key

  depends_on = [
    aws_iam_user.cd,
  ]
}
