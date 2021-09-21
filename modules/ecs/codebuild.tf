resource "aws_cloudwatch_log_group" "codebuild" {
  name = "/codebuild/${var.build_project_name}"
}

resource "aws_codebuild_project" "this" {
  name          = var.build_project_name
  description   = "CodeBuild Project for ${var.build_project_name}"
  build_timeout = 5
  service_role  = aws_iam_role.codebuild.arn

  source {
    type            = "CODECOMMIT"
    location        = aws_codecommit_repository.this.clone_url_http
    git_clone_depth = 1
    buildspec       = file(var.buildspec)
  }

  source_version = "refs/heads/master"

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.aws_account_id
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = aws_ecr_repository.this.name
    }

    environment_variable {
      name  = "TASK_FAMILY"
      value = aws_ecs_task_definition.this.family
    }

    environment_variable {
      name  = "EXECUTION_ROLE_ARN"
      value = aws_iam_role.task_exec.arn
    }

    environment_variable {
      name  = "TASK_ROLE_ARN"
      value = aws_iam_role.task.arn
    }

    environment_variable {
      name  = "CONTAINER_NAME"
      value = var.task_definition.container_name
    }

    environment_variable {
      name  = "LOGGROUP_NAME"
      value = var.task_definition.cwlogs_name
    }

    environment_variable {
      name  = "LOGGROUP_PREFIX"
      value = var.task_definition.cwlogs_prefix
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.codebuild.name
      stream_name = ""
    }

  }

}
