# Security Group, main.tf
variable "name" {
  description = "Name of the security group"
  type        = string
  # Technically optional, but name your security groups meaningfully
}

variable "vpc_id" {
  description = "Optional, VPC ID that the security group will be created in"
  default     = null # TODO: verify null or ""
  type        = string
}

variable "description" {
  description = "Optional, Description of the security group"
  type        = string
  default     = null
}

variable "region" {
  description = "Optional, Region that the security group will be created in"
  type        = string
  default     = null
}

variable "tags" {
  description = "Optional, map of tags assigned to the security group"
  type        = map(any)
  default     = {}
}


# Ingress Rules, ingress_rules.tf
variable "ipv4_ingress_rules" {
  description = "List of ipv4 ingress rules"
  type = list(
    object({
      cidr_ipv4   = string,
      from_port   = number,
      to_port     = number,
      ip_protocol = string,
      description = optional(string)
    })
  )
  default = {}
}

variable "ipv4_ingress_allow_all" {
  description = "List of ipv4 address to allow all ports and protocol"
  type = list(
    object({
      cidr_ipv4   = string,
      ip_protocol = string
    })
  )
}
