# Security Group, main.tf
variable "security_group_name" {
  description = "Name of the security group to create"
  type        = string
  # Technically optional, but name your security groups meaningfully
}

variable "vpc_id" {
  description = "Optional, VPC ID that the security group will be created in"
  default     = null # TODO: verify null or ""
  type        = string
}

variable "security_group_description" {
  description = "Optional, Description of the security group to create"
  type        = string
  default     = null
}

variable "region" {
  description = "Optional, Region that the security group will be created in"
  type        = string
  default     = null
}

variable "tags" {
  description = "Optional, map of tags assigned to the security group and rules"
  type        = map(any)
  default     = {}
}
