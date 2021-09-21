resource "null_resource" "docker_push" {
  depends_on = [aws_ecr_repository.this]

  provisioner "local-exec" {
    command = "$(aws ecr get-login --no-include-email --region ${var.aws_region})"
  }
  provisioner "local-exec" {
    command = "docker build -t ${var.ecr_name} -f ./modules/ecs/files/Dockerfile ."
  }
  provisioner "local-exec" {
    command = "docker tag ${var.ecr_name}:latest ${aws_ecr_repository.this.repository_url}:latest"
  }
  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.this.repository_url}:latest"
  }

}