# Simple 3-Tier VPC Infrastructure

This repository contains Terraform configurations for deploying a 3-tier VPC architecture in AWS, consisting of:

- A VPC with public, application, and database subnets across two availability zones
- An EC2 instance in the public subnet with internet access
- A PostgreSQL RDS database in the database subnet

## Architecture

The infrastructure is organized into three modules:
- vpc: Network infrastructure including VPC, subnets, and routing
- compute: EC2 instance configuration
- database: RDS PostgreSQL instance setup

## Prerequisites

- AWS CLI configured with profile 'roberto-main'
- Terraform installed

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review planned changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

## Resources Created

- VPC with 6 subnets (2 each for public, application, and database tiers)
- Internet Gateway
- NAT Gateway
- Route Tables
- EC2 instance in public subnet
- RDS PostgreSQL instance in database subnet