module "bastionwithnlb"{
    source = "./modules/bastion/"
    vpc_id                                = "vpc-0dac6c3c11599cf55"
    instance_profile                      = "ssmmessages"
    key_name                              = "bastion-pub"
    ec2_instance_size                     = "t2.micro"
    ec2_root_volume                       = "29"
    ec2_root_volume_delete_on_termination = false
    certificate_arn                       = "arn:aws:acm:ap-southeast-1:717535151694:certificate/11fa599b-fd17-4743-923e-48e8b5b6d30d"
    security_id="sg-0afcaa956f2de2b3f"
}