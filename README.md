# Simple 3-Tier VPC Infrastructure

This repository contains Terraform configurations for deploying a 3-tier VPC infrastructure with the following components:

- VPC with public and private subnets
- EC2 instances in the application tier
- RDS database in the data tier

## Module Structure

```
.
├── main.tf           # Root module configuration
├── variables.tf      # Root variables
├── outputs.tf        # Root outputs
├── terraform.tfvars  # Variable values
└── 3tier/
    ├── vpc/         # VPC module
    ├── compute/     # Compute module
    └── database/    # Database module
```

## Usage

1. Initialize Terraform:
```
terraform init
```

2. Review the plan:
```
terraform plan
```

3. Apply the configuration:
```
terraform apply
```

## Variables

See terraform.tfvars for default values. Key variables include:

- vpc_cidr: VPC CIDR block
- environment: Environment name (dev/staging/prod)
- instance_type: EC2 instance type
- db_instance_class: RDS instance class

## Outputs

- vpc_id: ID of the created VPC
- app_instance_ip: Public IP of application instance
- db_endpoint: RDS endpoint for connections