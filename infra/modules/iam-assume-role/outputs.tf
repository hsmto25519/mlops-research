output "arn" {
  description = "The ARN of the created IAM role."
  value       = aws_iam_role.main.arn
}
