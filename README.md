# 3-Tier VPC Infrastructure

## Architecture Overview
- VPC with public and private subnets across multiple AZs
- EC2 instance in public subnet with internet access
- PostgreSQL RDS instance in private subnet
- Security groups for EC2 and RDS instances

## Module Structure
```
3tier/
├── compute/     # EC2 instance configuration
├── database/    # RDS instance configuration
└── vpc/         # VPC and networking components
```

## Prerequisites
- AWS CLI configured
- Terraform installed
- Access to AWS account with required permissions

## Deployment Instructions
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

## Testing and Validation
Run the validation script:
```bash
chmod +x validate.sh
./validate.sh
```

## Key Variables
- VPC CIDR: 10.0.0.0/16
- Public subnet CIDR: 10.0.1.0/24
- Private subnet CIDR: 10.0.2.0/24
- EC2 instance type: t2.micro
- RDS instance class: db.t3.micro

## Outputs
- vpc_id: VPC identifier
- app_instance_ip: Public IP of EC2 instance
- db_endpoint: RDS endpoint

## Security Considerations
- EC2 instance in public subnet with restricted security group
- RDS instance in private subnet
- Security groups limit access to necessary ports only

## Customization Guidelines
Modify terraform.tfvars for custom configurations:
- CIDR ranges
- Instance types
- Database parameters