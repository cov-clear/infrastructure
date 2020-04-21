locals {
  project_name = "cov-clear-prod"
  domain_name  = "app.cov-clear.com"

  aws_region = "eu-west-1"

  public_subnets = [
    { availability_zone = "eu-west-1a", cidr = "10.0.0.0/22" },
    { availability_zone = "eu-west-1b", cidr = "10.0.4.0/22" },
    { availability_zone = "eu-west-1c", cidr = "10.0.8.0/22" }
  ]

  private_subnets = [
    { availability_zone = "eu-west-1a", cidr = "10.0.64.0/22" },
    { availability_zone = "eu-west-1b", cidr = "10.0.68.0/22" },
    { availability_zone = "eu-west-1c", cidr = "10.0.72.0/22" }
  ]
}

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

module "network" {
  source = "../../modules/network"

  short_name = local.project_name
  aws_region = local.aws_region
  cidr       = "10.0.0.0/16"

  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
}

resource "random_string" "db_password" {
  length  = 32
  special = false
}

module "database" {
  source = "../../modules/postgres"

  identifier        = "${local.project_name}-db"
  allocated_storage = 50
  db_name           = "cov_clear_prod"
  db_password       = random_string.db_password.result
  db_user           = "cov_clear_prod"
  engine_family     = "postgres12"
  engine_version    = "12.2"
  multi_az          = true
  instance_class    = "db.t3.medium"
  vpc_id            = module.network.vpc_id
  subnet_ids        = module.network.private_subnet_ids
  allowed_cidrs     = local.private_subnets.*.cidr
  storage_encrypted = true
}

module "kubernetes" {
  source = "../../modules/eks"

  aws_region    = local.aws_region
  cluster_name  = local.project_name
  public_access = true # TODO: Close control place access behind a bastion
  subnet_ids    = module.network.private_subnet_ids

  fargate_namespaces = [
    "kube-system",
    "prod-cov-clear-backend",
    "staging-cov-clear-backend",
    "kube-ingress",
  ]
}

module "backend_app" {
  source = "../../modules/backend"

  app_name    = "${local.project_name}-backend"
  domain_name = local.domain_name
}
