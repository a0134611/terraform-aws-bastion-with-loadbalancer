variable "key_name" {
  default     = "bastion-pub"
  description = "keyname"
  type        = string
}

variable "ec2_instance_size" {
  type        = string
  default     = "t2.micro"
  description = "The EC2 instance size"
}
variable "ec2_root_volume" {
  type        = string
  default     = "28"
  description = "The volume size for the root volume in GiB"
}
variable "ec2_root_volume_type" {
  type        = string
  default     = "gp2"
  description = "The type of data storage: standard, gp2, io1"
}
variable "ec2_root_volume_delete_on_termination" {
  default     = false
  description = "Delete the root volume on instance termination."
}
variable "vpc_id" {
  type = string
}
variable "instance_profile" {
  type = string
}
variable "security_id" {
  type = string
}
variable "ports" {
  type = map(object({
    target_port = number
    protocol    = string
  }))
  default = {
    "bastion" = {
      protocol    = "TCP"
      target_port = 22
    }
  }
}
variable "subnet_private_name" {
  type = string
}
variable "subnet_public_name" {
  type = string
}