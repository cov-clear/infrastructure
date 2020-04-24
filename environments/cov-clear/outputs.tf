output "vpc_region" {
  value = local.aws_region
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "eks_cluster_name" {
  value = local.project_name
}

#output "alb_role_arn" {
#  value = module.kubernetes.alb_role_arn
#}
#
#output "backend_uk_1_app_access_key" {
#  value = module.backend_app_uk_1.access_key
#}
#
#output "backend_uk_1_app_secret_key" {
#  value = module.backend_app_uk_1.secret_key
#}
#
#output "db_uk_1_endpoint" {
#  value = module.database_uk_1.endpoint
#}
#
#output "db_uk_1_username" {
#  value = module.database_uk_1.username
#}
#
#output "db_uk_1_password" {
#  value = module.database_uk_1.password
#}
