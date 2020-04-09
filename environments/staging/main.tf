module "network" {
  source = "../../modules/network"

  short_name = "cov-clear-staging"
  aws_region = "eu-west-1"
  cidr       = "10.64.0.0/16"

  public_subnets = [
    { availability_zone = "eu-west-1a", cidr = "10.64.0.0/22" },
    { availability_zone = "eu-west-1b", cidr = "10.64.4.0/22" },
    { availability_zone = "eu-west-1c", cidr = "10.64.8.0/22" }
  ]

  private_subnets = [
    { availability_zone = "eu-west-1a", cidr = "10.64.64.0/22" },
    { availability_zone = "eu-west-1b", cidr = "10.64.68.0/22" },
    { availability_zone = "eu-west-1c", cidr = "10.64.72.0/22" }
  ]
}

module "backend" {
  source = "../../modules/backend"

  app_name = "cov-clear-staging-backend"
}


resource "random_string" "db_password" {
  length  = 16
  special = false
}

module "database" {
  source = "../../modules/postgres"

  identifier        = "cov-clear-staging-db"
  allocated_storage = 5
  db_name           = "cov_clear"
  db_password       = random_string.db_password.result
  db_user           = "cov_clear"
  engine_family     = "postgres12"
  engine_version    = "12.2"
  multi_az          = true
  instance_class    = "db.t2.micro"
  subnet_ids        = module.network.private_subnet_ids
  storage_encrypted = true
}
