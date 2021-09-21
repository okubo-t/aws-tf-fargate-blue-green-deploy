terraform {

  required_providers {

    aws = {
      version = ">= 3.42.0"
      source  = "hashicorp/aws"

    }
  }
}

provider "aws" {

  region = var.aws_region

}