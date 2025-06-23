# Credit
# https://stackoverflow.com/users/7950592/cloudkollektiv
# https://stackoverflow.com/questions/58594506/how-to-for-each-through-a-listobjects-in-terraform-0-12
locals {
  # Create a map from list of rules 
  ipv4_egress_rules = {
    for rule in var.ipv4_egress_rules :
    "${rule.cidr_ipv4}-${rule.from_port}-${rule.to_port}-${rule.ip_protocol}"
    => rule
  }

  ipv4_egress_allow_all = {
    for rule in var.ipv4_egress_allow_all :
    rule.cidr_ipv4 => rule
  }

  security_group_egress_rules = {
    for rule in var.security_group_egress_rules :
    "${rule.referenced_security_group_id}-${rule.from_port}-${rule.to_port}-${rule.ip_protocol}" # TODO: check if key has a limit on no. of char
    => rule
  }

  security_group_egress_allow_all = {
    for rule in var.security_group_egress_allow_all :
    rule.referenced_security_group_id => rule
  }

  security_group_egress_prefix_list = {
    for rule in var.security_group_egress_prefix_list :
    "${rule.prefix_list_id}-${rule.from_port}-${rule.to_port}-${rule.ip_protocol}"
    => rule
  }
}


resource "aws_vpc_security_group_egress_rule" "allow_ipv4" {
  for_each          = local.ipv4_egress_rules
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = each.value.cidr_ipv4
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol
  description = lookup(each.value, "description", null)

  region = var.region
  tags   = var.tags
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
  for_each          = local.ipv4_egress_allow_all
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = each.value.cidr_ipv4
  ip_protocol = "-1"
  description = lookup(each.value, "description", null)

  region = var.region
  tags   = var.tags
}

resource "aws_vpc_security_group_egress_rule" "allow_security_group" {
  for_each          = local.security_group_egress_rules
  security_group_id = aws_security_group.this.id

  referenced_security_group_id = each.value.referenced_security_group_id
  from_port                    = each.value.from_port
  to_port                      = each.value.to_port
  ip_protocol                  = each.value.ip_protocol
  description                  = lookup(each.value, "description", null)

  region = var.region
  tags   = var.tags
}

resource "aws_vpc_security_group_egress_rule" "allow_all_security_group_id" {
  for_each          = local.security_group_egress_allow_all
  security_group_id = aws_security_group.this.id

  referenced_security_group_id = each.value.referenced_security_group_id
  ip_protocol                  = "-1"
  description                  = lookup(each.value, "description", null)

  region = var.region
  tags   = var.tags
}

resource "aws_vpc_security_group_egress_rule" "allow_prefix_list" {
  for_each          = local.security_group_egress_prefix_list
  security_group_id = aws_security_group.this.id

  prefix_list_id = each.value.prefix_list_id
  from_port      = each.value.from_port
  to_port        = each.value.to_port
  ip_protocol    = each.value.ip_protocol
  description    = lookup(each.value, "description", null)

  region = var.region
  tags   = var.tags
}
