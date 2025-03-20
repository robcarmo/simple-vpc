# Simple VPC Architecture

This repository contains Terraform code for a 3-tier VPC architecture in AWS with EC2 and RDS PostgreSQL.

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
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

## Testing and Validation

### Infrastructure Validation

```bash
# Verify VPC
aws ec2 describe-vpcs --profile roberto-main --filters "Name=tag:Name,Values=main" --query 'Vpcs[*].{VpcId:VpcId,CidrBlock:CidrBlock}'

# Check Subnets
aws ec2 describe-subnets --profile roberto-main --filters "Name=vpc-id,Values=<vpc-id>" --query 'Subnets[*].{SubnetId:SubnetId,CidrBlock:CidrBlock}'

# Verify EC2 Instance
aws ec2 describe-instances --profile roberto-main --filters "Name=tag:Name,Values=app-server" --query 'Reservations[*].Instances[*].{InstanceId:InstanceId,State:State.Name,PublicIP:PublicIpAddress}'

# Check RDS Instance
aws rds describe-db-instances --profile roberto-main --query 'DBInstances[*].{DBInstanceIdentifier:DBInstanceIdentifier,Status:DBInstanceStatus,Endpoint:Endpoint.Address}'
```

### Connectivity Testing

```bash
# Test EC2 Internet Access
ssh ec2-user@<ec2-public-ip> 'ping -c 4 8.8.8.8'

# Test RDS Connection (from EC2)
ssh ec2-user@<ec2-public-ip> 'psql -h <rds-endpoint> -U postgres -d postgres'
```

### Cleanup

```bash
terraform destroy -var-file="terraform.tfvars"
```