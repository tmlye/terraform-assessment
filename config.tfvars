region             = "eu-central-1"
profile            = "personal-terraform"
additional_tags    = {}
vpc_cidr_block     = "10.0.0.0/16"
enable_private_dns = true
subnet_cidr_blocks = {
  "eu-central-1a" = "10.0.1.0/24",
  "eu-central-1b" = "10.0.2.0/24",
}
map_public_ip_on_launch = false
instances = {
  "0" = {
    type = "t3.micro",
    ami  = "ami-05ff5eaef6149df49",
    az   = "eu-central-1a"
  },
  "1" = {
    type = "t3.micro",
    ami  = "ami-05ff5eaef6149df49",
    az   = "eu-central-1b"
  }
}
