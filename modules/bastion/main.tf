
resource "aws_instance" "bastion" {
  ami                     = data.aws_ami.ubuntu.id
  key_name                = var.key_name
  instance_type           = var.ec2_instance_size
  monitoring              = true
  vpc_security_group_ids  = [var.security_id]
  subnet_id               = tolist(data.aws_subnet_ids.private.ids)[0]
  disable_api_termination = var.ec2_root_volume_delete_on_termination
  iam_instance_profile    = var.instance_profile
  tags = {
    Terraform   = "true"
    Environment = "${terraform.workspace}"
    Name        = "Bastion-${terraform.workspace}"
  }
  root_block_device {
    encrypted             = true
    volume_type           = var.ec2_root_volume_type
    volume_size           = var.ec2_root_volume
    delete_on_termination = var.ec2_root_volume_delete_on_termination
    tags = {
      Name = "bastion-${terraform.workspace}-root-block"
    }
  }
}
resource "null_resource" "status" {
  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.bastion.id}"

  }
  depends_on = [aws_instance.bastion]
}
resource "aws_lb" "nlb" {
  name                             = "nlb-${terraform.workspace}"
  internal                         = false
  load_balancer_type               = "network"
  subnets                          = data.aws_subnet_ids.public.ids
  enable_cross_zone_load_balancing = true
  enable_deletion_protection       = false

  tags = {
    Environment = "${terraform.workspace}"
  }
  depends_on = [aws_instance.bastion]
}


resource "aws_lb_listener" "nlblisten" {
  for_each = var.ports

  load_balancer_arn = aws_lb.nlb.arn

  protocol = each.value.protocol
  port     = each.value.target_port

  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lbtg[each.key].arn
  }
}

resource "aws_lb_target_group" "lbtg" {
  for_each = var.ports

  name     = "bastion-${terraform.workspace}-tg"
  port     = each.value.target_port
  protocol = each.value.protocol
  vpc_id   = var.vpc_id


  depends_on = [
    aws_lb.nlb
  ]

}

resource "aws_lb_target_group_attachment" "tgattach" {
  for_each = var.ports

  target_group_arn = aws_lb_target_group.lbtg[each.key].arn
  target_id        = aws_instance.bastion.id
  port             = each.value.target_port
}