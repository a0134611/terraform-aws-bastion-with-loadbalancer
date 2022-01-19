output "private_ip" {
  value = aws_instance.bastion.private_ip
}

output "nlbdns" {
  value = aws_lb.nlb.dns_name
}