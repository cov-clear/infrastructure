resource "random_string" "db_password_ee" {
  length  = 32
  special = false
}

module "database_ee" {
  source = "../../modules/postgres"

  identifier        = "cov-clear-ee"
  allocated_storage = 20
  db_name           = "cov_clear"
  db_password       = random_string.db_password_ee.result
  db_user           = "cov_clear"
  engine_family     = "postgres12"
  engine_version    = "12.2"
  multi_az          = false
  instance_class    = "db.t3.micro"
  vpc_id            = module.network.vpc_id
  subnet_ids        = module.network.private_subnet_ids
  allowed_cidrs     = local.private_subnets.*.cidr
  storage_encrypted = true
}

module "backend_app_ee" {
  source = "../../modules/backend"

  app_name    = "cov-clear-ee"
  domain_name = "app.immunitypassport.co"
  namespace   = "ee"

  iam_oidc_arn      = module.kubernetes.iam_oidc_arn
  iam_oidc_provider = module.kubernetes.iam_oidc_provider
}

