#!/bin/bash
# Infrastructure validation script

# Check if VPC exists
echo "Validating VPC..."
vpc_id=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=3tier-vpc" --query 'Vpcs[0].VpcId' --output text)
if [ "$vpc_id" != "None" ]; then
  echo "✓ VPC found: $vpc_id"
else
  echo "✗ VPC not found"
  exit 1
fi

# Check subnets
echo "Validating subnets..."
public_subnet=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=public-subnet" --query 'Subnets[0].SubnetId' --output text)
private_subnet=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=private-subnet" --query 'Subnets[0].SubnetId' --output text)

if [ "$public_subnet" != "None" ] && [ "$private_subnet" != "None" ]; then
  echo "✓ Public and private subnets found"
else
  echo "✗ Subnets missing"
  exit 1
fi

# Check EC2 instance
echo "Validating EC2 instance..."
ec2_instance=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=app-server" --query 'Reservations[0].Instances[0].InstanceId' --output text)
if [ "$ec2_instance" != "None" ]; then
  echo "✓ EC2 instance found: $ec2_instance"
else
  echo "✗ EC2 instance not found"
  exit 1
fi

# Check RDS instance
echo "Validating RDS instance..."
rds_instance=$(aws rds describe-db-instances --query 'DBInstances[?DBInstanceIdentifier==`app-database`].DBInstanceIdentifier' --output text)
if [ "$rds_instance" != "" ]; then
  echo "✓ RDS instance found: $rds_instance"
else
  echo "✗ RDS instance not found"
  exit 1
fi

echo "All infrastructure components validated successfully!"
