# Terraform Assessment

I used AWS for this assessment. Make is used as a wrapper around Terraform to pass in the respective tfvars files.

You can use `make init`, `make plan` and `make apply`.

## Code Structure

The Terraform code is split in two files:
- [network.tf](network.tf) for creating the VPC, subnets, routes and IGW.
- [instances.tf](instances.tf) for creating the instances, security group and SSH key

The script for the circular ping is located in [scripts/circular_ping.sh](scripts/circular_ping.sh)

For variables please see [variables.tf](variables.tf) and [config.tfvars](config.tfvars)

## Reasoning for using external data

I initially thought I could use the cloud init scripts ("user_data") to run the circular ping,
but it is not possible to get the output of the cloud init scripts in Terraform, because Terraform is already finished at that point.
I then checked whether I could use a provisioner for this, but didn't see a way of getting the output of the provisioner without redirecting to a file.
This is why I opted for using an [external data source](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source),
which allows getting the output of whatever runs. I then wrote a bash script which SSHes into the instances and assembles the output.
