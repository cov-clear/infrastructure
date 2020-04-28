resource "random_string" "db_password_uk" {
  length  = 32
  special = false
}

module "database_uk" {
  source = "../../modules/postgres"

  identifier        = "cov-clear-uk"
  allocated_storage = 20
  db_name           = "cov_clear"
  db_password       = random_string.db_password_uk.result
  db_user           = "cov_clear"
  engine_family     = "postgres12"
  engine_version    = "12.2"
  multi_az          = true
  instance_class    = "db.t3.medium"
  vpc_id            = module.network.vpc_id
  subnet_ids        = module.network.private_subnet_ids
  allowed_cidrs     = local.private_subnets.*.cidr
  storage_encrypted = true
}

module "backend_app_uk" {
  source = "../../modules/backend"

  app_name    = "cov-clear-uk"
  domain_name = "uk.cov-clear.com"
  namespace   = "uk"

  iam_oidc_arn      = module.kubernetes.iam_oidc_arn
  iam_oidc_provider = module.kubernetes.iam_oidc_provider
}

