output "public_alb_dns_name" {
  value = aws_lb.public.dns_name
}

output "public_alb_arn" {
  value = aws_lb.public.arn
}

output "web_target_group_arn" {
  value = aws_lb_target_group.web.arn
}

output "internal_alb_dns_name" {
  value = aws_lb.internal.dns_name
}

output "app_target_group_arn" {
  value = aws_lb_target_group.app.arn
}
