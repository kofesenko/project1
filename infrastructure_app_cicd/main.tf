terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket  = "my-tf-state-bucket-rndcharskf"
    key     = "Development/terraform.tfstate"
    region  = "eu-west-1"
    profile = "terraform_admin"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "terraform_admin"
}

resource "aws_codecommit_repository" "code_repo" {
  repository_name = "python_app"
  description     = "Repository for python application"
}
#local task to push our app to the created codecommit repo
resource "null_resource" "image" {

  provisioner "local-exec" {
    command     = <<-EOT
       git init
       git add .
       git commit -m "Initial Commit"
       git remote add origin ${aws_codecommit_repository.code_repo.clone_url_http}
       git push -u origin master
   EOT
    working_dir = "app"
  }
  depends_on = [
    aws_codecommit_repository.code_repo,
  ]

}
#local task to clean up .git 
resource "null_resource" "clean_up" {

  provisioner "local-exec" {
    when        = destroy
    command     = <<EOF
       rm -rf .git/
   EOF
    working_dir = "app"

  }
}
#Create S3 bucket to store artifacts from codepipeline
resource "aws_s3_bucket" "cicd_bucket" {
  bucket        = var.artifacts_bucket_name
  acl           = "private"
  force_destroy = true
}