provider "aws" {
  region = var.region
}

resource "aws_iam_user" "terraform" {
  name = var.iam_user_name
}

resource "aws_iam_access_key" "terraform" {
  user = aws_iam_user.terraform.name
}

resource "aws_iam_user_policy" "terraform" {
  name = "terraform-policy"
  user = aws_iam_user.terraform.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*",
          "dynamodb:*",
          "ec2:*",
          "rds:*"
        ]
        Resource = "*"
      }
    ]
  })
}
