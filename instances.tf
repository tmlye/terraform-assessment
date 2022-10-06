resource "aws_key_pair" "access" {
  key_name   = "instance-access"
  public_key = var.ssh_public_key
}

resource "aws_instance" "assessment" {
  for_each = var.instances

  ami                    = each.value.ami
  key_name               = aws_key_pair.access.key_name
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
  description = "Allow inbound traffic from VPC and SSH from home"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow all inbound from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  ingress {
    description = "Allow SSH from home"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.home_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-vpc"
  }
}

data "external" "circular_ping" {
  program = ["/bin/sh", "${path.module}/scripts/circular_ping.sh"]

  query = {
    ips = join(";", [for i in aws_instance.assessment : "${i.public_ip} ${i.private_ip}"])
  }
}
