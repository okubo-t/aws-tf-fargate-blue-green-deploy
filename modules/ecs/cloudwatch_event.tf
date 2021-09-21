resource "aws_cloudwatch_event_rule" "this" {
  name        = "${aws_codepipeline.this.name}-event"
  description = "CloudWatch Events for ${aws_codepipeline.this.name}"

  event_pattern = <<EOH
{
  "source": [
    "aws.codecommit"
  ],
  "detail-type": [
    "CodeCommit Repository State Change"
  ],
  "resources": [
    "${aws_codecommit_repository.this.arn}"
  ],
  "detail": {
    "event": [
      "referenceCreated",
      "referenceUpdated"
    ],
    "referenceType": [
      "branch"
    ],
    "referenceName": [
      "master"
    ]
  }
}
EOH
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "CodePipeline"
  arn       = aws_codepipeline.this.arn
  role_arn  = aws_iam_role.cloudwatch_event.arn
}
