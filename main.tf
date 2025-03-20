provider "aws" {
  profile = "roberto-main"
}

module "vpc" {
  source = "./3tier/vpc"
}

module "compute" {
  source = "./3tier/compute"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_ids[0]
}

module "database" {
  source = "./3tier/database"
  vpc_id = module.vpc.vpc_id
  database_subnet_ids = module.vpc.database_subnet_ids
}
