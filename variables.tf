variable "region" {
  type = string
}

variable "profile" {
  type = string
}

variable "additional_tags" {
  type = map(string)
}

variable "vpc_cidr_block" {
  type = string
}

variable "enable_private_dns" {
  type = bool
}

variable "subnet_cidr_blocks" {
  type = map(string)
}

variable "map_public_ip_on_launch" {
  type = bool
}

variable "instances" {
  type = map(object({
    type = string
    ami  = string
    az   = string
  }))
}
