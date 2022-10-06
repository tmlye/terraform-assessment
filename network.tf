resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_private_dns
  enable_dns_hostnames = var.enable_private_dns

  tags = {
    Name = "main"
  }
}

resource "aws_default_security_group" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-default"
  }
}

resource "aws_default_network_acl" "main" {
  default_network_acl_id = aws_vpc.main.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  lifecycle {
    ignore_changes = [subnet_ids]
  }

  tags = {
    Name = "main-default"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  for_each = var.subnet_cidr_blocks

  availability_zone       = each.key
  cidr_block              = each.value
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id                  = aws_vpc.main.id

  tags = {
    AvailabilityZone = lower(each.key)
    Name             = lower("main-${each.key}")
  }
}

resource "aws_route_table" "main" {
  for_each = var.subnet_cidr_blocks

  vpc_id = aws_vpc.main.id

  tags = {
    AvailabilityZone = lower(each.key)
    Name             = lower("main-${each.key}")
  }
}

resource "aws_route_table_association" "main" {
  for_each = var.subnet_cidr_blocks

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[each.key].id
}

resource "aws_route" "igw" {
  for_each = var.subnet_cidr_blocks

  route_table_id         = aws_route_table.main[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}
