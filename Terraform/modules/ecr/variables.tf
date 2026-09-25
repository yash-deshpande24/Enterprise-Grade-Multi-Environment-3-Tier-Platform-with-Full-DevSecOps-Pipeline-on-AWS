output "web_repo_url" {
  value = aws_ecr_repository.web.repository_url
}

output "app_repo_url" {
  value = aws_ecr_repository.app.repository_url
}
