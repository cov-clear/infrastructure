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

