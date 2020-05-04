locals {
  project_name = "cov-clear"
  aws_region   = "eu-west-1"

  cidr = "10.0.0.0/16"

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

  admins = {
    "jose.galarza"       = {},
    "kostas.stamatoukos" = {},
  }

  developers = {
    "uku.tammet" = {},
  }

  continuous_delivery_bots = {
    "github" = {},
  }
}

module "emails" {
  source = "../../modules/emails"

  domain     = "cov-clear.com"
  short_name = local.project_name
}

module "network" {
  source = "../../modules/network"

  short_name = local.project_name
  aws_region = local.aws_region
  cidr       = local.cidr

  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
}

module "kubernetes" {
  source = "../../modules/eks"

  aws_region   = local.aws_region
  cluster_name = local.project_name
  subnet_ids   = module.network.private_subnet_ids

  admins                   = module.users.admins
  continuous_delivery_bots = module.users.continuous_delivery_bots
  developers               = module.users.developers

  # TODO: Close control plane behind a bastion
  public_access = true

  fargate_namespaces = {
    "kube-ingress" : {
      "subnet_ids" : module.network.private_subnet_ids
    },
    "kube-system" : {
      "subnet_ids" : module.network.private_subnet_ids
    },
    "uk" : {
      "subnet_ids" : module.network.private_subnet_ids
    },
    "ee" : {
      "subnet_ids" : module.network.private_subnet_ids
    },
  }
}
