output "private_ip" {
  value = module.bastionwithnlb.private_ip
}

output "nlb" {
  value = module.bastionwithnlb.nlbdns
}