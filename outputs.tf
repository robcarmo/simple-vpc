output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "app_instance_ip" {
  description = "Public IP of the application instance"
  value       = module.compute.public_ip
}

output "db_endpoint" {
  description = "Database connection endpoint"
  value       = module.database.endpoint
}
