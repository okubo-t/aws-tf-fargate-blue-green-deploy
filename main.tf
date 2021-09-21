###################
# Network SAMPLE
###################
module "network" {
  source = "./modules/network"

  vpc = {
    name = "${var.prefix}-${var.env}-vpc"
    cidr = "10.0.0.0/16"
  }

  igw_name = "${var.prefix}-${var.env}-igw"

  public_subnet_a = {
    name = "${var.prefix}-${var.env}-public-a"
    cidr = "10.0.1.0/24"
  }

  public_subnet_c = {
    name = "${var.prefix}-${var.env}-public-c"
    cidr = "10.0.2.0/24"
  }

  private_subnet_a = {
    name = "${var.prefix}-${var.env}-private-a"
    cidr = "10.0.10.0/24"
  }

  private_subnet_c = {
    name = "${var.prefix}-${var.env}-private-c"
    cidr = "10.0.20.0/24"
  }

}

############################################
# ECS on Fargate Blue/Green Deploy SAMPLE
############################################
module "ecs" {
  source = "./modules/ecs"

  ## AWS Account ID
  aws_account_id = data.aws_caller_identity.current.account_id

  ## Region
  aws_region = var.aws_region

  ## Network
  vpc_id = module.network.vpc_id
  subnet_ids = [
    module.network.public_subnet_a_id,
    module.network.public_subnet_c_id,
  ]
  my_remote_ip = var.my_remote_ip

  ## ALB
  alb_name = "${var.prefix}-${var.env}-sample-app-alb"

  ## ECS Cluster
  cluster_name = "${var.prefix}-${var.env}-cluster"

  ## ECR
  ecr_name = "${var.prefix}-sample-app"

  ## ECS Task
  task_definition = {
    name           = "${var.prefix}-${var.env}-sample-app-task"
    container_name = "${var.prefix}-sample-app"
    cwlogs_name    = "/aws/ecs/${var.prefix}-sample-app"
    cwlogs_prefix  = var.env

  }

  ## ECS Service
  service_name  = "${var.prefix}-${var.env}-sample-app-svc"
  desired_count = 1

  ## CodePipeline
  codepipeline_name = "${var.prefix}-${var.env}-sample-app-cp"

  ## Stage > Source > CodeCommit 
  repository_name        = "${var.prefix}-sample-app"
  repository_description = "Sample App"

  ## Stage > Build > CodeBuild
  build_project_name = "${var.prefix}-${var.env}-sample-app-cb"

  ## Stage > Deploy > CodeDeploy
  codedeploy_app_name              = "${var.prefix}-sample-app"
  codedeploy_deployment_group_name = var.env

}