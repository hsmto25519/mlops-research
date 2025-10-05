resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge({ "Name" = var.name }, var.tags)
}

resource "aws_vpc_security_group_ingress_rule" "ipv4" {
  for_each = { for rule in var.ingress_rules : "${rule.cidr_ipv4}-${rule.from_port}-${rule.to_port}-${rule.ip_protocol}" => rule }

  security_group_id            = aws_security_group.main.id
  cidr_ipv4                    = each.value.cidr_ipv4 != null ? each.value.cidr_ipv4 : null
  referenced_security_group_id = each.value.referenced_security_group_id != null ? each.value.referenced_security_group_id : null
  description                  = each.value.description
  ip_protocol                  = each.value.ip_protocol
  from_port                    = each.value.from_port
  to_port                      = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "ipv4" {
  for_each = { for rule in var.egress_rules : "${coalesce(rule.cidr_ipv4, rule.referenced_security_group_id)}-${rule.from_port}-${rule.to_port}-${rule.ip_protocol}" => rule }

  security_group_id            = aws_security_group.main.id
  cidr_ipv4                    = each.value.cidr_ipv4 != null ? each.value.cidr_ipv4 : null
  referenced_security_group_id = each.value.referenced_security_group_id != null ? each.value.referenced_security_group_id : null
  description                  = each.value.description
  ip_protocol                  = each.value.ip_protocol
  from_port                    = each.value.from_port
  to_port                      = each.value.to_port
}

