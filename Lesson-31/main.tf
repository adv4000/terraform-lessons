provider "aws" {
  region = var.region
}


module "vpc-dev" {
  source   = "./modules/aws_network"
  env      = "dev"
  vpc_cidr = var.vpc_settings["dev"]
}

module "vpc-staging" {
  source   = "./modules/aws_network"
  env      = "stag"
  vpc_cidr = var.vpc_settings["stag"]
}

module "vpc-prod" {
  source   = "./modules/aws_network"
  env      = "prod"
  vpc_cidr = var.vpc_settings["prod"]

  depends_on = [module.vpc-dev, module.vpc-staging] # <--Supported only in Terraform 0.13+
}

module "vpc" {
  count  = 2 # <--Supported only in Terraform 0.13+
  source = "./modules/aws_network"
  env    = "demo-${count.index + 1}"
}

module "vpc_list" {
  for_each = var.vpc_settings # <--Supported only in Terraform 0.13+
  source   = "./modules/aws_network"
  env      = each.key
  vpc_cidr = each.value
}
