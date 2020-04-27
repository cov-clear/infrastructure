output "vpc_region" {
  value = local.aws_region
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "eks_cluster_name" {
  value = local.project_name
}

output "alb_role_arn" {
  value = module.kubernetes.alb_role_arn
}

#
# UK outputs
#

output "db_uk_endpoint" {
  value = module.database_uk.endpoint
}

output "db_uk_username" {
  value = module.database_uk.username
}

output "db_uk_password" {
  value = module.database_uk.password
}

#
# Estonian Outputs
#

output "db_ee_endpoint" {
  value = module.database_ee.endpoint
}

output "db_ee_username" {
  value = module.database_ee.username
}

output "db_ee_password" {
  value = module.database_ee.password
}
