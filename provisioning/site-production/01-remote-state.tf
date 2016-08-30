#
# Define the location of remote state files defining shared outputs
#
# This allows resources shared across projects (such as networking infrastructure) to be kept in sync without needing
# manual updates and allowing scalable, centralised management.
#
# This file relies on Terraform providers being previously configured - see '00-providers.tf'

# The BAS-AWS remote state includes outputs such as identifiers for VPC subnets, VPC security groups and DNS zones
#
# State source: https://s3-eu-west-1.amazonaws.com/bas-terraform-remote-state-prod/v1/BAS-AWS/terraform.tfstate
# Terraform source: https://www.terraform.io/docs/providers/terraform/d/remote_state.html
data "terraform_remote_state" "BAS-AWS" {
    backend = "s3"
    config {
        bucket = "bas-terraform-remote-state-prod"
        key = "v1/BAS-AWS/terraform.tfstate"
        region = "eu-west-1"
    }
}

# The BAS-PACKER-VM-TEMPLATES remote state includes AMI identifiers for EC2 instances
#
# State source: https://s3-eu-west-1.amazonaws.com/bas-terraform-remote-state-dev/v1/BAS-PACKER-VM-TEMPLATES/terraform.tfstate
# Terraform source: https://www.terraform.io/docs/providers/terraform/d/remote_state.html
data "terraform_remote_state" "BAS-PACKER-VM-TEMPLATES" {
    backend = "s3"
    config {
        bucket = "bas-terraform-remote-state-prod"
        key = "v1/BAS-PACKER-VM-TEMPLATES/terraform.tfstate"
        region = "eu-west-1"
    }
}
