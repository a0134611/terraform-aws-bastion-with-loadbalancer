variable "key_name" {
  default     = "bastion-pub"
  description = "Bastion Server required key pair name, please share key name"
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
  description = "The Load Balancer and Bastion server required VPC ID "
}
variable "instance_profile" {
  type = string
  description = "Bastion Server Required Instance Profile Name"
}
variable "security_id" {
  type = string
  description = "Bastion Server required security group ID"
}
variable "env" {
  type = string
  description = "Type here env variable like dev, stg, uat .."
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
  description = "Bastion Server launched in Private subnet , so please share private subnet Name"
}
variable "subnet_public_name" {
  type = string
  description = "Network Load Balancer launched in Public subnet , so please share Public Name for filter like Pub*"
}