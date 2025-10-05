output "id" {
  description = "The ID of the SageMaker Domain."
  value       = aws_sagemaker_domain.main.id
}

output "arn" {
  description = "The ARN of the SageMaker Domain."
  value       = aws_sagemaker_domain.main.arn
}

output "url" {
  description = "The URL of the SageMaker Domain."
  value       = aws_sagemaker_domain.main.url
}

output "user_profile_arns" {
  description = "A map of the user profile names to their ARNs."
  value = {
    for k, v in aws_sagemaker_user_profile.this : k => v.arn
  }
}
