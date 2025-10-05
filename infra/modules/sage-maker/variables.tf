variable "domain_name" {
  description = "The name for the SageMaker Domain."
  type        = string
}

variable "auth_mode" {
  description = "The authentication mode for the SageMaker Domain. Valid values are 'IAM' and 'SSO'."
  type        = string
  default     = "IAM"
  validation {
    condition     = contains(["IAM", "SSO"], var.auth_mode)
    error_message = "Valid values for auth_mode are 'IAM' and 'SSO'."
  }
}

variable "vpc_id" {
  description = "The ID of the VPC for the SageMaker Domain."
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the SageMaker Domain."
  type        = list(string)
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role for the Domain's default."
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs for the SageMaker Domain's default space settings."
  type        = list(string)
}

variable "efs_file_system_id" {
  description = "The ID of the EFS file system for the custom file system configuration."
  type        = string
}

variable "efs_file_system_path" {
  description = "The path within the EFS file system for the custom file system configuration."
  type        = string
  default     = "/"
}

variable "user_profile_list" {
  description = "A set of user profile names to create within the SageMaker Domain."
  type        = set(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to apply to the resources."
  type        = map(string)
  default     = {}
}
