output "id" {
  description = "The ID of the created security group."
  value       = aws_security_group.main.id
}

output "arn" {
  description = "The ARN of the created security group."
  value       = aws_security_group.main.arn
}

output "name" {
  description = "The name of the created security group."
  value       = aws_security_group.main.name
}
