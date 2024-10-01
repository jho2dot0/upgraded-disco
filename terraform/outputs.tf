output "ecr_repository_url" {
  value = aws_ecr_repository.app_repo.repository_url
}

output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "The DNS name of the load balancer"
}

output "cloudfront_distribution_domain_name" {
  value       = aws_cloudfront_distribution.main.domain_name
  description = "The domain name of the CloudFront distribution"
}

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "Name of the ECS cluster"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the VPC"
}

output "subnet_ids" {
  value       = aws_subnet.main[*].id
  description = "IDs of the subnets"
}

output "allow_http_sg_id" {
  value       = aws_security_group.allow_http.id
  description = "ID of the security group allowing HTTP traffic"
}

output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "ARN of the ECS task execution role"
}

output "ecs_task_cpu" {
  value       = var.ecs_task_cpu
  description = "CPU of the ECS task"
}

output "ecs_task_memory" {
  value       = var.ecs_task_memory
  description = "Memory of the ECS task"
}
