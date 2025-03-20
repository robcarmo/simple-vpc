resource "aws_db_instance" "main" {
  identifier        = "${var.environment}-db"
  engine           = var.engine
  engine_version   = var.engine_version
  instance_class   = var.instance_class
  allocated_storage = var.allocated_storage

  username = var.db_username
  password = var.db_password

  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnet_ids
}
