resource "aws_efs_file_system" "main" {
  creation_token   = var.name
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true

  tags = merge({ "Name" = var.name }, var.tags)
}

resource "aws_efs_mount_target" "this" {
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = var.subnet_id
  security_groups = var.security_group_ids
}
