provider "aws" {
  profile = "cov-clear"
  region  = "eu-west-1"
  version = "~> 2.55"
}

provider "external" {
  version = "~> v1.2"
}

provider "local" {
  version = "~> v1.4"
}

provider "random" {
  version = "~> v2.2"
}

provider "template" {
  version = "~> v2.1"
}

terraform {
  backend "s3" {
    bucket  = "cov-clear-terraform"
    encrypt = true
    key     = "output/cov-clear.tfstate"
    profile = "cov-clear"
    region  = "eu-west-1"
  }
}
