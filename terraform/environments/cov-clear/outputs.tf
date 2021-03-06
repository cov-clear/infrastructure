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

output "continuous_delivery_bots" {
  value = module.users.continuous_delivery_bots
}

#
# Estonia outputs
#

output "db_ee_url" {
  value = module.database_ee.connection_url
}

output "backend_app_ee_arn" {
  value = module.backend_app_ee.role_arn
}
