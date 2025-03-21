variable "region" {
  description = "AWS region"
  type        = string
}

variable "state_bucket_name" {
  description = "Name of S3 bucket for Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of DynamoDB table for state locking"
  type        = string
}
