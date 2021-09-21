resource "aws_iam_role" "cloudwatch_event" {
  name               = "${var.codepipeline_name}-event-role"
  assume_role_policy = file(var.cloudwatch_event_trust_policy)
}

resource "aws_iam_policy" "cloudwatch_event" {
  name   = "${var.codepipeline_name}-event-policy"
  policy = file(var.cloudwatch_event_policy)
}

resource "aws_iam_role_policy_attachment" "cloudwatch_event" {
  policy_arn = aws_iam_policy.cloudwatch_event.arn
  role       = aws_iam_role.cloudwatch_event.id
}

resource "aws_iam_role" "codepipeline" {
  name               = "${var.codepipeline_name}-role"
  assume_role_policy = file(var.codepipeline_trust_policy)
}

resource "aws_iam_policy" "codepipeline" {
  name   = "${var.codepipeline_name}-policy"
  policy = file(var.codepipeline_policy)
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy_attachment" {
  policy_arn = aws_iam_policy.codepipeline.arn
  role       = aws_iam_role.codepipeline.id
}

resource "aws_iam_role" "codebuild" {
  name               = "${var.build_project_name}-role"
  assume_role_policy = file(var.codebuild_trust_policy)
}

resource "aws_iam_policy" "codebuild" {
  name   = "${var.build_project_name}-policy"
  policy = file(var.codebuild_policy)
}

resource "aws_iam_role_policy_attachment" "codebuild" {
  policy_arn = aws_iam_policy.codebuild.arn
  role       = aws_iam_role.codebuild.id
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryPowerUser" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  role       = aws_iam_role.codebuild.id
}

resource "aws_iam_role" "codedeploy" {
  name               = "${var.codedeploy_app_name}-${var.codedeploy_deployment_group_name}-role"
  assume_role_policy = file(var.codedeploy_trust_policy)
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRoleForECS" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
  role       = aws_iam_role.codedeploy.id
}