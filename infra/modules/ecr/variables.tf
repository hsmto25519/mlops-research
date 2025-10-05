variable "name" {
  description = "the ecr repository name"
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Valid values are 'MUTABLE' and 'IMMUTABLE'."
  type        = string
  default     = "IMMUTABLE"
}

variable "tags" {
  description = "A map of additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}
