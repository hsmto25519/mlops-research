variable "name" {
  description = "The name for the EFS file system, used in the creation token and Name tag."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to create the EFS mount target in."
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the EFS mount target."
  type        = list(string)
}

variable "tags" {
  description = "A map of additional tags to apply to the EFS file system."
  type        = map(string)
  default     = {}
}
