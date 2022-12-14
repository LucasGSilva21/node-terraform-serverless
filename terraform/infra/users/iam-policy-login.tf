resource "aws_iam_policy" "login_policy" {
  name = "${var.environment}-login-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:Query",
        ]
        Effect   = "Allow"
        Resource = "${aws_dynamodb_table.users.arn}/index/${var.environment}-email-gsi"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}
