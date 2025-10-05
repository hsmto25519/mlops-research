resource "aws_sagemaker_domain" "main" {
  domain_name = var.domain_name
  auth_mode   = var.auth_mode
  vpc_id      = var.vpc_id
  subnet_ids  = var.subnet_ids

  default_space_settings {
    execution_role  = var.execution_role_arn
    security_groups = var.security_group_ids

    custom_file_system_config {
      efs_file_system_config {
        file_system_id   = var.efs_file_system_id
        file_system_path = var.efs_file_system_path
      }
    }
  }

  default_user_settings {
    execution_role = var.execution_role_arn
  }

  tags = merge({ Name = var.domain_name }, var.tags)
}

resource "aws_sagemaker_user_profile" "this" {
  for_each = { for user_profile in var.user_profile_list : user_profile => user_profile }

  domain_id         = aws_sagemaker_domain.main.id
  user_profile_name = each.key

  user_settings {
    execution_role = var.execution_role_arn
  }

  tags = merge({ Name = each.key }, var.tags)
}
