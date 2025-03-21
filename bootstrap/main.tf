# main.tf
provider "aws" {
  region = "us-east-1" # Hardcoded AWS region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "tfstate-dev-qjau56sf"
}


#resource "aws_s3_bucket_acl" "terraform_state_acl" {
#  bucket = aws_s3_bucket.terraform_state.id
#  acl    = "private"
#}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "terraform_state_lifecycle" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    id     = "PreventNoncurrentVersionExpiration"
    status = "Enabled"
    
    filter {
      prefix = ""  # Empty prefix means apply to all objects
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "statetable-${var.environment}" # Append environment to table name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = var.environment
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}
