module "production_network" {
  source = "../../modules/network"

  short_name = "cov-clear-prod"
  aws_region = "eu-west-1"
  cidr       = "10.0.0.0/16"

  public_subnets = [
    { availability_zone = "eu-west-1a", cidr = "10.0.0.0/24" },
    { availability_zone = "eu-west-1b", cidr = "10.0.1.0/24" },
    { availability_zone = "eu-west-1c", cidr = "10.0.2.0/24" }
  ]

  private_subnets = [
    { availability_zone = "eu-west-1a", cidr = "10.0.100.0/24" },
    { availability_zone = "eu-west-1b", cidr = "10.0.101.0/24" },
    { availability_zone = "eu-west-1c", cidr = "10.0.102.0/24" }
  ]
}

module "production_backend" {
  source = "../../modules/backend"

  app_name = "cov-clear-prod-backend"
}


resource "random_string" "prod_db_password" {
  length  = 16
  special = false
}

module "production_database" {
  source = "../../modules/postgres"

  identifier = "cov-clear-production-db"
  allocated_storage = 20
  db_name = "cov_clear"
  db_password = random_string.prod_db_password.result
  db_user = "cov_clear"
  engine_family = "postgres12"
  engine_version = "12.2"
  multi_az = true
  instance_class = "db.m5.large"
  subnet_ids = module.production_network.private_subnet_ids
  storage_encrypted = true
}