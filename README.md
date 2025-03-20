# simple-vpc

A Terraform project that creates a 3-tier VPC architecture in AWS with the following components:

## Modules

- `vpc`: Creates VPC with public, application and database subnets
- `compute`: Deploys web servers in public subnet
- `database`: Sets up RDS instance in database subnet

## Usage

```hcl
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
```
