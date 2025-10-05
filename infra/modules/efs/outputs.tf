output "id" {
  description = "The ID of the EFS file system."
  value       = aws_efs_file_system.main.id
}

output "arn" {
  description = "The ARN of the EFS file system."
  value       = aws_efs_file_system.main.arn
}

output "dns_name" {
  description = "The DNS name for the EFS file system."
  value       = aws_efs_file_system.main.dns_name
}

output "mount_target_id" {
  description = "The ID of the EFS mount target."
  value       = aws_efs_mount_target.this.id
}
