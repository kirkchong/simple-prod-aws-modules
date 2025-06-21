
resource "aws_security_group" "this" {
  name        = var.security_group_name
  vpc_id      = var.vpc_id
  description = var.security_group_description
  region      = var.region
  tags        = var.tags
}
