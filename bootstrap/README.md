# Bootstrap Infrastructure

This directory contains Terraform configurations for bootstrapping the infrastructure:
- S3 bucket for Terraform state
- DynamoDB table for state locking
- IAM user and permissions for Terraform

## Usage
1. Apply backend configuration first:
```bash
cd terraform/backend
terraform init
terraform apply
```

2. Apply IAM configuration:
```bash
cd ../iam
terraform init
terraform apply
```

3. Configure GitHub repository secrets with the generated AWS credentials
