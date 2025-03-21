# variables.tf
variable "environment" {
  description = "Environment (dev, prod, or stag)"
  type        = string
  validation {
    condition     = contains(["dev", "prod", "stag"], var.environment)
    error_message = "Environment must be one of: dev, prod, stag."
  }
}