module "emails" {
  source = "../emails"

  domain = "cov-clear.com"
}

module "users" {
  source = "../users"

  developers = [
    "jose.galarza",
  ]
}
