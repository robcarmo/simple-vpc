# Simple VPC Architecture

This repository contains Terraform configurations for a 3-tier VPC architecture in AWS with EC2 and RDS PostgreSQL.

## Architecture

- VPC with public and private subnets
- EC2 instance in public subnet with internet access
- RDS PostgreSQL instance in private subnet
- Security groups for EC2 and RDS

## Prerequisites

- AWS CLI configured with profile `roberto-main`
- Terraform installed

## Deployment

```bash
terraform init
terraform plan -var-profile="roberto-main"
terraform apply -var-profile="roberto-main"
```

## Testing and Validation

### Infrastructure Validation Script
```bash
#!/bin/bash
# Save as validate.sh

# Set AWS Profile
export AWS_PROFILE=roberto-main

# Get VPC ID
VPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=main" --query 'Vpcs[0].VpcId' --output text)

# Validate VPC
echo "Checking VPC..."
aws ec2 describe-vpcs --vpc-ids $VPC_ID

# Validate Subnets
echo "Checking Subnets..."
aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID"

# Check EC2 Instance
echo "Checking EC2..."
aws ec2 describe-instances --filters "Name=tag:Name,Values=app-server" --query 'Reservations[*].Instances[*]'

# Check RDS
echo "Checking RDS..."
aws rds describe-db-instances --query 'DBInstances[?DBInstanceIdentifier==`main-postgres`]'
```

### Component Testing

#### VPC Testing
```bash
# Test Internet Connectivity
aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$VPC_ID"

# Test Route Tables
aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$VPC_ID"
```

#### EC2 Testing
```bash
# Get EC2 Public IP
EC2_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=app-server" --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

# Test SSH Connection
ssh -i your-key.pem ec2-user@$EC2_IP
```

#### RDS Testing
```bash
# Get RDS Endpoint
RDS_ENDPOINT=$(aws rds describe-db-instances --query 'DBInstances[?DBInstanceIdentifier==`main-postgres`].Endpoint.Address' --output text)

# Test Database Connection (from EC2)
psql -h $RDS_ENDPOINT -U postgres -d postgres
```