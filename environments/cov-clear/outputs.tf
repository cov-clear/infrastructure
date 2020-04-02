output "production_backend_access_key" {
  value = "${module.production_backend.access_key}"
}

output "production_backend_secret_key" {
  value = "${module.production_backend.secret_key}"
}
