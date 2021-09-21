resource "aws_iam_role" "task" {
  name               = "${var.task_definition.name}-role"
  assume_role_policy = file(var.ecs_task_trust_policy)
}

resource "aws_iam_policy" "task" {
  name   = "${var.task_definition.name}-policy"
  policy = file(var.ecs_task_policy)
}

resource "aws_iam_role_policy_attachment" "task" {
  policy_arn = aws_iam_policy.task.arn
  role       = aws_iam_role.task.id
}

resource "aws_iam_role" "task_exec" {
  name               = "${var.task_definition.name}-exec-role"
  assume_role_policy = file(var.ecs_task_trust_policy)
}

resource "aws_iam_role_policy_attachment" "AmazonECSTaskExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.task_exec.id
}