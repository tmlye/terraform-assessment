variable "region" {
  type        = string
  description = "The AWS region to use"
}

variable "profile" {
  type        = string
  description = "The AWS profile in your ~/.aws/config to use"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "enable_private_dns" {
  type        = bool
  description = "Whether to enable private DNS on the VPC"
}

variable "subnet_cidr_blocks" {
  type        = map(string)
  description = "A map of AZs to CIDRs for the subnets"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Whether instances should get public IPs when launched"
}

variable "instances" {
  description = "Map of instances with their respective settings"
  type = map(object({
    type = string
    ami  = string
    az   = string
  }))
}

variable "ssh_public_key" {
  description = "The SSH public key to use for the instances"
  type        = string
}

variable "home_ip" {
  description = "Your IP for opening SSH on the security group"
  type        = string
}
