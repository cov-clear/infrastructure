# TODO: Disabled until we receive the credits
#module "network" {
#  source = "../../modules/network"
#
#  short_name = "cov-clear-prod"
#  aws_region = "eu-west-1"
#  cidr       = "10.0.0.0/16"
#
#  public_subnets = [
#    { availability_zone = "eu-west-1a", cidr = "10.0.0.0/22" },
#    { availability_zone = "eu-west-1b", cidr = "10.0.4.0/22" },
#    { availability_zone = "eu-west-1c", cidr = "10.0.8.0/22" }
#  ]
#
#  private_subnets = [
#    { availability_zone = "eu-west-1a", cidr = "10.0.64.0/22" },
#    { availability_zone = "eu-west-1b", cidr = "10.0.68.0/22" },
#    { availability_zone = "eu-west-1c", cidr = "10.0.72.0/22" }
#  ]
#}

module "backend" {
  source = "../../modules/backend"

  app_name = "cov-clear-prod-backend"
}

