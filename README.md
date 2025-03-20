# Simple VPC with 3-Tier Architecture

## Architecture
- VPC with public and private subnets
- EC2 instance in public subnet with internet access
- PostgreSQL RDS instance in private subnet
- Security groups for web and database access

## Module Structure
- vpc: Network infrastructure
- compute: EC2 instance configuration
- database: RDS PostgreSQL setup

## Testing and Validation
1. Run terraform apply to create infrastructure
2. Execute ./validate.sh to verify deployment
3. Manual checks:
   - Access EC2 via SSH
   - Verify web server response
   - Test database connectivity from EC2

## Validation Script
Use validate.sh in root directory to perform automated checks