output "backend_app_access_key" {
  value = module.backend_app.access_key
}

output "backend_app_secret_key" {
  value = module.backend_app.secret_key
}

output "db_endpoint" {
  value = module.database.endpoint
}

output "db_username" {
  value = module.database.username
}

output "db_password" {
  value = module.database.password
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "vpc_region" {
  value = local.aws_region
}

output "alb_role_arn" {
  value = module.kubernetes.alb_role_arn
}

output "eks_cluster_name" {
  value = local.project_name
}
