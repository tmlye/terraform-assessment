resource "aws_instance" "assessment" {
  for_each = var.instances

  ami                    = each.value.ami
  instance_type          = each.value.type
  availability_zone      = each.value.az
  subnet_id              = aws_subnet.main[each.value.az].id
  vpc_security_group_ids = [aws_security_group.allow_vpc.id]

  tags = {
    Name = lower("instance-${each.key}")
  }
}

resource "aws_security_group" "allow_vpc" {
  name        = "allow-vpc"
  description = "Allow inbound traffic from VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow all inbound from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-icmp"
  }
}
