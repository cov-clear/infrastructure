module "users" {
  source = "../../modules/users"

  developers = [
    "jose.galarza",
    "kostas.stamatoukos"
  ]
}

module "emails" {
  source = "../../modules/emails"

  domain     = "cov-clear.com"
  short_name = "cov-clear"
}
