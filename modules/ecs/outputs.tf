output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "ecr_repository" {
  value = aws_ecr_repository.this.repository_url
}

output "service_name" {
  value = aws_ecs_service.this.name
}

output "codecommit_repository" {
  value = aws_codecommit_repository.this.clone_url_http
}