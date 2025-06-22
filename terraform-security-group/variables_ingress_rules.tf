# Ingress Rules, ingress_rules.tf
# variable "tags" in variable_main.tf
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
  default = []
}

variable "ipv4_ingress_allow_all" {
  description = "List of ipv4 address to allow all ports and protocol"
  type = list(
    object({
      cidr_ipv4   = string,
      description = optional(string)
    })
  )
  default = []
}

variable "security_group_ingress_rules" {
  description = "List of security group ingress rules"
  type = list(
    object({
      referenced_security_group_id = string,
      from_port                    = number,
      to_port                      = number,
      ip_protocol                  = string,
      description                  = optional(string)
    })
  )
  default = []
}

variable "security_group_ingress_allow_all" {
  description = "List of security groups to allow all ports and protocol"
  type = list(
    object({
      referenced_security_group_id = string,
      description                  = optional(string)
    })
  )
  default = []
}

variable "security_group_ingress_prefix_list" {
  description = "List of prefix list ingress rules"
  type = list(
    object({
      prefix_list_id = string,
      from_port      = number,
      to_port        = number,
      ip_protocol    = string,
      description    = optional(string)
    })
  )
  default = []
}
