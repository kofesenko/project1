terraform {
  required_version = ">= 0.12"
}


provider "aws" {
  region = var.aws_region
  profile = "terraform_admin"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "my-tf-state-bucket-rndcharskf"##to do - generate rnd name and pass it to infrastructure_app_cicd
  acl           = "private"
  force_destroy = true #for cleanup purposes

  tags = {
    Name        = "State bucket"
    Environment = var.env_name
  }
}