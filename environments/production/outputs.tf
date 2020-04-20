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
