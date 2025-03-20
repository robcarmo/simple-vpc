variable "vpc_id" {
  type = string
  description = "ID of the VPC"
}

variable "database_subnet_ids" {
  type = list(string)
  description = "List of database subnet IDs"
}

variable "web_security_group_id" {
  type = string
  description = "ID of web server security group"
}
