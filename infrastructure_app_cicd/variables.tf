variable "ACCOUNT_ID" {}

variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-1"
}

# Example of a list variable. Use element function to retrieve element 
variable "availability_zones" {
  default = ["eu-west-1a", "eu-west-1b"]
}

variable "cidr_block" {
  default = "10.1.0.0/16"
}

variable "env" {
  description = "Environment"
  default     = "Development"
}

variable "python_project_repository_branch" {
  description = "Python project branch"
  default     = "master"
}

variable "artifacts_bucket_name" {
  description = "S3 Bucket for storing artifacts"
  default     = "artifacts-bucket-cicd"
}

variable "container_port" {
  description = "python app container port"
  default     = 5000
}

variable "container_name" {
  default = "python-app"
}


