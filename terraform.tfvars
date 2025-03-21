vpc_cidr = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
environment = "dev"

ami_id = "ami-01f5a0b78d6089704"
instance_type = "t2.micro"

db_engine = "mysql"
db_engine_version = "8.0"
db_instance_class = "db.t3.micro"
db_allocated_storage = 20
db_username = "admin"
db_password = "password123"
