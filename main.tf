terraform {
  backend "s3" {
    bucket         = "tfstate-dev-qjau56sf" # Replace with your actual bucket name
    key            = "tfstate"                  # Updated state file name
    region         = "us-east-1"
    dynamodb_table = "statetable-dev"               # Updated table name
    encrypt        = true
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "vpc" {
  source = "./3tier/vpc"

  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  environment        = var.environment
}

module "compute" {
  source = "./3tier/compute"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  public_subnet_id  = module.vpc.public_subnet_ids[0]
  security_group_id = module.vpc.app_security_group_id
  environment       = var.environment

  depends_on = [module.vpc]
}

module "database" {
  source = "./3tier/database"

  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  db_username       = var.db_username
  db_password       = var.db_password
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_id  = module.vpc.app_security_group_id
  environment        = var.environment

  depends_on = [module.vpc]
}
