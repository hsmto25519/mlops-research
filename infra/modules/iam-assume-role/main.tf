resource "aws_iam_role" "main" {
  name = var.name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = var.service_principal
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_defined" {
  for_each = toset(var.aws_managed_policies)

  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
}
