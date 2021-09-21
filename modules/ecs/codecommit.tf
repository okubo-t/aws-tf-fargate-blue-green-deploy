resource "aws_codecommit_repository" "this" {
  repository_name = var.repository_name
  description     = var.repository_description
}