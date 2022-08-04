output "code_commit_repo" {
  value = aws_codecommit_repository.code_repo.clone_url_http
}

output "elb" {
  value = aws_lb.loadbalancer.dns_name
}
