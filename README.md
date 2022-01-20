# AWS Bastion with NLB Terraform module

Terraform module which create bastion with NLB on AWS.

## Usage

```hcl
module "bastionwithnlb"{
    source = "./modules/bastion/"
    vpc_id                                = var.vpc_id
    instance_profile                      = "abcddddd"
    key_name                              = "public-key"
    security_id                           = subnet-eddcdzz4
    subnet_private_name                   = "private-subnet-1"
    subnet_public_name                    = "public*"
    env                                   = "dev"
}
```