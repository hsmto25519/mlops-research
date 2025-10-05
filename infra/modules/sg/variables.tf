variable "name" {
  description = "The name of the security group."
  type        = string
}

variable "description" {
  description = "The description of the security group."
  type        = string
  default     = "Main security group"
}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "ingress_rules" {
  description = "A list of ingress rules to apply to the security group."
  type = list(object({
    description                  = optional(string)
    ip_protocol                  = string
    from_port                    = number
    to_port                      = number
    cidr_ipv4                    = optional(string)
    referenced_security_group_id = optional(string)
  }))
  default = []
}

variable "egress_rules" {
  description = "A list of egress rules to apply to the security group."
  type = list(object({
    description                  = optional(string)
    ip_protocol                  = string
    from_port                    = number
    to_port                      = number
    cidr_ipv4                    = optional(string)
    referenced_security_group_id = optional(string)
  }))
  default = []
}
