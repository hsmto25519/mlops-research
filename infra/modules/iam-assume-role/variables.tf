variable "name" {
  description = "The name for the IAM role."
  type        = string
}

variable "service_principal" {
  description = "The AWS service principal that is allowed to assume this role (e.g., 'sagemaker.amazonaws.com')."
  type        = string
}

variable "aws_managed_policies" {
  description = "A list of AWS managed policies to attach (e.g., ['AmazonS3FullAccess']). The ARN prefix is automatically added."
  type        = list(string)
  default     = []
}
