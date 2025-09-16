module "bastionhost" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = local.subnetid
  vpc_security_group_ids = [data.aws_ssm_parameter.bastionhost.value]
  tags = merge(var.common_tags, var.ec2_tags,

    {
      Name = "${var.project_name}-${var.environment}-bastionhost"
    }

  )

}
