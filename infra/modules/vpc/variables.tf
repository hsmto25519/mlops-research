variable "name" {
  description = "A name for the project to prefix resource names."
  type        = string
  default     = "myvpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable "availability_zone" {
  description = "an Availability Zone to create subnets in."
  type        = string
  default     = "ap-northeast-1a"
}

variable "public_subnet_cidr" {
  description = "A CIDR block for the public subnet."
  type        = string
}

variable "private_subnet_cidr" {
  description = "A CIDR block for the private subnet."
  type        = string
}

variable "tags" {
  description = "A map of additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}
