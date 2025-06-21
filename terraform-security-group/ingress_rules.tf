/* input
# ipv4 ingress
[
{
    cidr_ipv4:
    from_port:
    to_port:
    ip_protocol: #required
    description:
}
]

# ingress allow all
    # option 1
    [
        "0.0.0.0/0",
        "1.1.1.1/32"
    ]

    # option 2, leaning towards this for consistency in format
    [
    {
        cidr_ipv4: "0.0.0.0/0",
        ip_protocol = -1 
    }
    ] 
tags={}

*/

# Credit
# https://stackoverflow.com/users/7950592/cloudkollektiv
# https://stackoverflow.com/questions/58594506/how-to-for-each-through-a-listobjects-in-terraform-0-12
locals {
  # Create a map from list of rules 
  ipv4_ingress_rules = {
    for rule in var.ipv4_ingress_rules :
    "${rule.cidr_ipv4}-${rule.from_port}-${rule.to_port}-${rule.ip_protocol}"
    => rule
  }

  ipv4_ingress_allow_all = {
    for rule in var.ipv4_ingress_allow_all :
    rule.cidr_ipv4 => rule
  }
}


resource "aws_vpc_security_ingress_rule" "allow_ipv4" {
  for_each = local.ipv4_ingress_rules

  cidr_ipv4   = each.value.cidr_ipv4
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol
  description = lookup(each.value, "description", null)
}

resource "aws_vpc_security_ingress_rule" "allow_all_ipv4" {
  for_each = local.ipv4_ingress_allow_all

  cidr_ipv4   = each.value.cidr_ipv4
  ip_protocol = each.value.ip_protocol
}
