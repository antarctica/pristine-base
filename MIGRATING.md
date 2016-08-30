# BAS Base Project (Pristine) - Base Flavour - Migration Guide

All changes needed to migrate from one version of this project to the next will documented in this file.

**Note:** Migration information is not available prior to migrating from version **0.2.0** to **0.3.0**

## 0.3.0 --> [Unreleased]

*These steps should be completed in the order listed below*

1. remove the `provisioning/handlers` directory
2. add these lines [1] to the `.gitignore` file
3. remove the leading space, if present, from `README.md`
4. remove:
    * `.rsync-filter`
    * `provisioning/app-deploy-production.yml`
5. rename:
    * `provisioning/inventories/terraform-dynamic-inventory` to 
    `provisioning/inventories/terraform-prod-env-dynamic-inventory`
6. update `provisioning/inventories/vagrant-dynamic-inventory` as follows:
    * in the `get_host_provider()` function, add [2] after the `// Normalise 'provider' value` if statement
7. update `provisioning/site-production/01-remote-state.tf` as follows:
    * replace [3] with [4]
    * replace [5] with [6]
8. update `provisioning/site-production/05-provisioning.tf` as follows:
    * change `command = "ansible-playbook -i ../inventories/terraform-dynamic-inventory 25-terraform-foundation.yml"` 
    to ` command = "ansible-playbook -i ../inventories/terraform-prod-env-dynamic-inventory 06-terraform-foundation.yml"`
9. update `provisioning/site-production/30-ec2-instances` as follows:
    * change the comment `# This file relies on remote state resources being previously configured for shared outputs - see '01-remote-state.tf'` 
    to # This file relies on data sources being previously configured for shared outputs - see '01-remote-state.tf'`
    * for the `"aws_instance"` resource:
        * change the comment `# This resource implicitly depends on the 'atlas_artifact.antarctica-trusty-latest' resource` to 
        `# This resource explicitly depends on outputs from the the 'terraform_remote_state.BAS-PACKER-VM-TEMPLATES' data source`
        * change the comment `# This resource implicitly depends on outputs from the the 'terraform_remote_state.BAS-AWS' resource` to 
        `# This resource explicitly depends on outputs from the the 'terraform_remote_state.BAS-AWS' data source`
        * change the `ami` property `${terraform_remote_state.BAS-PACKER-VM-TEMPLATES.output.ANTARCTICA-TRUSTY-3-3-0-AMI-ID}` to 
        `${data.terraform_remote_state.BAS-PACKER-VM-TEMPLATES.ANTARCTICA-TRUSTY-3-4-0-AMI-ID}`
        * change the `subnet_id` property `terraform_remote_state.BAS-AWS.output.BAS-AWS-VPC-2-External-Subnet-ID` to 
        `data.terraform_remote_state.BAS-AWS.BAS-AWS-VPC-2-External-Subnet-ID`
        * change the `vpc_security_group_ids` property to:
            * `terraform_remote_state.BAS-AWS.output.BAS-AWS-VPC-2-SG-All-Egress-ID` to 
            `data.terraform_remote_state.BAS-AWS.BAS-AWS-VPC-2-SG-All-Egress-ID`
            * `terraform_remote_state.BAS-AWS.output.BAS-AWS-VPC-2-SG-Ping-ID` to 
            `data.terraform_remote_state.BAS-AWS.BAS-AWS-VPC-2-SG-Ping-ID`
            * `terraform_remote_state.BAS-AWS.output.BAS-AWS-VPC-2-SG-SSH-BAS-VPC-2-ID` to 
            `data.terraform_remote_state.BAS-AWS.BAS-AWS-VPC-2-SG-SSH-BAS-VPC-2-ID`
            * `terraform_remote_state.BAS-AWS.output.BAS-AWS-VPC-2-SG-SSH-BAS-ID` to 
            `data.terraform_remote_state.BAS-AWS.BAS-AWS-VPC-2-SG-SSH-BAS-ID`
    * for the external `aws_route53_record` resource:
        * change the comment `# This resource implicitly depends on outputs from the the 'terraform_remote_state.BAS-AWS' resource` 
        to `# This resource implicitly depends on outputs from the the 'terraform_remote_state.BAS-AWS' data source`
        * change the `zone_id` property `terraform_remote_state.BAS-AWS.output.BAS-AWS-External-Subdomain-ID` to 
        `data.terraform_remote_state.BAS-AWS.BAS-AWS-External-Subdomain-ID`
    * for the internal `aws_route53_record` resource:
        * change the comment `# This resource implicitly depends on outputs from the the 'terraform_remote_state.BAS-AWS' resource` 
        to `# This resource implicitly depends on outputs from the the 'terraform_remote_state.BAS-AWS' data source`
        * change the `zone_id` property `terraform_remote_state.BAS-AWS.output.BAS-AWS-Internal-Subdomain-ID` to 
        `data.terraform_remote_state.BAS-AWS.BAS-AWS-Internal-Subdomain-ID`

[1]
```
# Ansible playbook retry files
*.retry
```

[2]
```php
if ($message[4] == 'virtualbox') {
    $host['provider'] = 'virtualbox';
}
```

[3]
```
# Terraform source: https://www.terraform.io/docs/providers/terraform/r/remote_state.html
resource "terraform_remote_state" "BAS-AWS" {
```
[4]
```
# Terraform source: https://www.terraform.io/docs/providers/terraform/d/remote_state.html
data "terraform_remote_state" "BAS-AWS" {
```

[5]
```
# Terraform source: https://www.terraform.io/docs/providers/terraform/r/remote_state.html
resource "terraform_remote_state" "BAS-AWS" {
```
[6]
```
# Terraform source: https://www.terraform.io/docs/providers/terraform/d/remote_state.html
data "terraform_remote_state" "BAS-PACKER-VM-TEMPLATES" {
```

## 0.2.0 --> 0.3.0

*These steps should be completed in the order listed below*

1. ensure `CHANGELOG.md` is spelt correctly, as the previous version contained a typo, `mv CHANAGELOG.md CHANGELOG.md`
2. overwrite `provisioning/inventories/vagrant-dynamic-inventory` with the file in this version
3. overwrite `provisioning/site-production/01-providers` with the file in this version
4. overwrite `provisioning/site-production/02-remote-state` with the file in this version
5. update `provisioning/site-production/30-ec2-instances.tf` as follows
    * replace the top comment lines with [1]
    * remove the `antarctica-trusty-latest` Atlas resource
    * update the `aim` property of the EC2 instance to:
    `"${terraform_remote_state.BAS-PACKER-VM-TEMPLATES.output.ANTARCTICA-TRUSTY-3-3-0-AMI-ID}"`
    * update the `subnet` property of the EC2 instance to: 
    `"${terraform_remote_state.BAS-AWS.output.BAS-AWS-VPC-2-External-Subnet-ID}"`
    * update the `security_group_ids` property of the EC2 instance to [2]
6. update `provisioning/galaxy.yml`
    * `system-core` to at least `0.3.0`
    * `system-users` to at least `2.0.0`
    * `system-firewall` to at least `0.3.0`
    * `system-ssh` to at least `0.3.0`
    * Add `bas-ansible-roles-collection.system-users` at, at least version `0.2.0`

[1]

```
# This file relies on Terraform providers being previously configured - see '00-providers.tf'
# This file relies on remote state resources being previously configured for shared outputs - see '01-remote-state.tf'
```

[2]

```
vpc_security_group_ids = [
    "${terraform_remote_state.BAS-AWS.output.BAS-AWS-VPC-2-SG-All-Egress-ID}",
    "${terraform_remote_state.BAS-AWS.output.BAS-AWS-VPC-2-SG-Ping-ID}",
    "${terraform_remote_state.BAS-AWS.output.BAS-AWS-VPC-2-SG-SSH-BAS-VPC-2-ID}",
    "${terraform_remote_state.BAS-AWS.output.BAS-AWS-VPC-2-SG-SSH-BAS-ID}"
]
```
