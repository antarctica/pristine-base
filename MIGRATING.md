# BAS Base Project (Pristine) - Base Flavour - Migration Guide

All changes needed to migrate from one version of this project to the next will documented in this file.

**Note:** Migration information is not available prior to migrating from version **0.2.0** to **0.3.0**

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
