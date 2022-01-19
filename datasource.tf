data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnet" "private" {
  vpc_id = var.vpc_id
  filter {
    name   = "tag:Name"
    values = ["prvt-subnet-1"]
  }
}
data "aws_subnet_ids" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name = "pub*"
  }
}