##########
# ALB
##########
output "prod_url" {
  value = "http://${module.ecs.alb_dns_name}"
}

output "test_url" {
  value = "http://${module.ecs.alb_dns_name}:10080"
}

##############
# CodeCommit
##############
output "codecommit_repository" {
  value = module.ecs.codecommit_repository
}