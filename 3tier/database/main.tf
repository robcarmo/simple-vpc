resource "aws_db_instance" "postgres" {
  engine               = "postgres"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  subnet_ids          = var.database_subnet_ids
  
  tags = {
    Name = "postgres-db"
  }
}

resource "aws_security_group" "database" {
  vpc_id = var.vpc_id
  
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.web_security_group_id]
  }
}
