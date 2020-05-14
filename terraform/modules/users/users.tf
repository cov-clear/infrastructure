resource "aws_iam_user" "admins" {
  for_each = var.admins

  name = each.key
}

resource "aws_iam_user_group_membership" "admins" {
  for_each = var.admins

  user = each.key
  groups = [
    aws_iam_group.admins.name,
  ]

  depends_on = [
    aws_iam_user.admins,
  ]
}

resource "aws_iam_user" "developers" {
  for_each = var.developers

  name = each.key
}

resource "aws_iam_user_group_membership" "developers" {
  for_each = var.developers

  user = each.key
  groups = [
    aws_iam_group.developers.name,
  ]

  depends_on = [
    aws_iam_user.developers,
  ]
}

resource "aws_iam_user" "cd" {
  for_each = var.continuous_delivery_bots

  name = each.key
}

resource "aws_iam_user_group_membership" "cd" {
  for_each = var.continuous_delivery_bots

  user = each.key
  groups = [
    aws_iam_group.cd.name,
  ]

  depends_on = [
    aws_iam_user.cd,
  ]
}

resource "aws_iam_access_key" "cd" {
  for_each = var.continuous_delivery_bots

  user = each.key

  depends_on = [
    aws_iam_user.cd,
  ]
}
