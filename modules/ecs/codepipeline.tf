resource "aws_s3_bucket" "artifact_store" {
  bucket        = "${var.codepipeline_name}-artifact"
  acl           = "private"
  force_destroy = true
}

resource "aws_codepipeline" "this" {
  name     = var.codepipeline_name
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.artifact_store.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      run_order        = 1
      name             = "Source"
      namespace        = "SourceVariables"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        RepositoryName       = aws_codecommit_repository.this.repository_name
        BranchName           = "master"
        OutputArtifactFormat = "CODE_ZIP"
        PollForSourceChanges = "false"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      namespace        = "BuildVariables"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.this.name
      }
    }
  }

  /*
  stage {
    name = "Approval"

    action {
      category  = "Approval"
      name      = "DeployApproval"
      owner     = "AWS"
      provider  = "Manual"
      region    = var.aws_region
      run_order = 1
      version   = "1"
    }
  }
*/

  stage {
    name = "Deploy"

    action {
      name      = "Deploy"
      category  = "Deploy"
      owner     = "AWS"
      provider  = "CodeDeployToECS"
      region    = var.aws_region
      run_order = 1
      version   = "1"

      configuration = {
        ApplicationName                = aws_codedeploy_app.this.name
        DeploymentGroupName            = var.codedeploy_deployment_group_name
        TaskDefinitionTemplateArtifact = "BuildArtifact"
        AppSpecTemplateArtifact        = "BuildArtifact"
        Image1ArtifactName             = "BuildArtifact"
        Image1ContainerName            = "IMAGE1_NAME"

      }

      input_artifacts = [
        "BuildArtifact",
      ]

    }
  }

}
