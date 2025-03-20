provider "aws" {
  region  = var.aws_region
  profile = "roberto-main"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
