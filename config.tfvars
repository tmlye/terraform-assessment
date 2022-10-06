region             = "eu-central-1"
profile            = "personal-terraform"
additional_tags    = {}
vpc_cidr_block     = "10.0.0.0/16"
enable_private_dns = true
subnet_cidr_blocks = {
  "eu-central-1a" = "10.0.1.0/24",
  "eu-central-1b" = "10.0.2.0/24",
}
map_public_ip_on_launch = true
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
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9qncpXJ30tLfxHvGf0ArAXIKSCmBteqwycIxvWzxSDRjs5WTN5lexD2CIdNUgU0ojSTgrH4sidVY2kaDzFOPaDILx7sC1Q4ROIk6hMsWEdSgCOnar0IruSUQZe+ZZ9ZMzSzOzS1YAJrCzIAnGmAC6Zs3wG9KEeHyRT07zj52cb+M+KJFETJOcn6RVCp48CPFSCMBlWc57iUFafPjrys5NOg3XPSdmQbyKrm8v/31v6HsyImHz4uR3Cvd3W13ch2GoHDxMOrgZ6yq4Wx0ttvZVepBMXgLhsrSDHYQ62PFVsZ9ERRx8Qccs2RmVjCIUyPbjgfO/yNdGgCYA8QNizfFX se@saschaeglau.com"
home_ip        = "62.226.130.97/32"
