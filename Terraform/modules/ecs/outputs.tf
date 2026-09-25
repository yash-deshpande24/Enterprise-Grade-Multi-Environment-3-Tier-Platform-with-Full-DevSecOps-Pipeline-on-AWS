output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "web_service_name" {
  value = aws_ecs_service.web.name
}

output "app_service_name" {
  value = aws_ecs_service.app.name
}
