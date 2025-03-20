#!/bin/bash

echo "Running infrastructure validation..."

# Check VPC
vpc_id=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=3tier-vpc" --query 'Vpcs[0].VpcId' --output text)
if [ ! -z "$vpc_id" ]; then
    echo "✅ VPC exists: $vpc_id"
else
    echo "❌ VPC not found"
fi

# Check EC2
instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=web-server" --query 'Reservations[0].Instances[0].InstanceId' --output text)
if [ ! -z "$instance_id" ] && [ "$instance_id" != "None" ]; then
    echo "✅ EC2 instance running: $instance_id"
else
    echo "❌ EC2 instance not found"
fi

# Check RDS
db_status=$(aws rds describe-db-instances --query 'DBInstances[0].DBInstanceStatus' --output text)
if [ "$db_status" == "available" ]; then
    echo "✅ RDS instance available"
else
    echo "❌ RDS instance not ready"
fi

# Web server check
public_ip=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
if curl -s -m 5 http://$public_ip > /dev/null; then
    echo "✅ Web server responding"
else
    echo "❌ Web server not responding"
fi

chmod +x validate.sh
