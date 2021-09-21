variable "aws_account_id" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "vpc_id" {
  type = string
}

variable "alb_name" {
  type = string
}

variable "internal" {
  type    = bool
  default = false
}

variable "target_type" {
  type    = string
  default = "ip"
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "my_remote_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "subnet_ids" {
  type = list(string)
}

variable "cluster_name" {
  type    = string
  default = "cluster"
}

variable "ecr_name" {
  type    = string
  default = "ecr"
}

variable "task_definition_file" {
  type    = string
  default = "./modules/ecs/ecs_taskdef.json"
}

variable "task_definition" {
  type = map(string)
  default = {
    name           = "taskdef"
    container_name = "container"
    image_url      = "image_url"
    cwlogs_region  = "ap-northeast-1"
    cwlogs_name    = "cwlog"
    cwlogs_prefix  = "dev"

  }
}

variable "ecs_task_trust_policy" {
  type    = string
  default = "./modules/ecs/iam_policy/ecs_task_trust_policy.json"
}

variable "ecs_task_policy" {
  type    = string
  default = "./modules/ecs/iam_policy/ecs_task_policy.json"
}

variable "service_name" {
  type    = string
  default = "svc"
}

variable "desired_count" {
  type    = number
  default = 0
}

variable "cloudwatch_event_trust_policy" {
  type    = string
  default = "./modules/ecs/iam_policy/cloudwatch_event_trust_policy.json"
}

variable "cloudwatch_event_policy" {
  type    = string
  default = "./modules/ecs/iam_policy/cloudwatch_event_policy.json"
}

variable "codepipeline_name" {
  type = string
}

variable "codepipeline_trust_policy" {
  type    = string
  default = "./modules/ecs/iam_policy/codepipeline_trust_policy.json"
}

variable "codepipeline_policy" {
  type    = string
  default = "./modules/ecs/iam_policy/codepipeline_policy.json"
}

variable "repository_name" {
  type = string
}

variable "repository_description" {
  type = string
}

variable "build_project_name" {
  type = string
}

variable "buildspec" {
  default = "./modules/ecs/buildspec.yml"
}

variable "codebuild_trust_policy" {
  type    = string
  default = "./modules/ecs/iam_policy/codebuild_trust_policy.json"
}

variable "codebuild_policy" {
  type    = string
  default = "./modules/ecs/iam_policy/codebuild_policy.json"
}

variable "codedeploy_app_name" {
  type = string
}

variable "codedeploy_deployment_group_name" {
  type = string
}

variable "codedeploy_trust_policy" {
  type    = string
  default = "./modules/ecs/iam_policy/codedeploy_trust_policy.json"
}