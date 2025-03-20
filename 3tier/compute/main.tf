resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id

  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "${var.environment}-app"
  }
}
