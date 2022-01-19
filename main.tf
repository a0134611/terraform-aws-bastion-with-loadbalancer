module "bastionwithnlb" {
  source              = "./modules/bastion/"
  vpc_id              = var.vpc_id
  instance_profile    = var.instance_profile
  key_name            = var.key_name
  security_id         = var.security_id
  subnet_private_name = var.subnet_private_name
  subnet_public_name  = var.subnet_public_name
}