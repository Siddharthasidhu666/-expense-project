module "bastionhost" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = local.subnetid
  vpc_security_group_ids = [data.aws_ssm_parameter.bastionhost.value]
  create_security_group  = false
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "optional" # ✅ Allows both IMDSv1 and IMDSv2
    http_put_response_hop_limit = 8
    instance_metadata_tags      = "enabled"
  }

  tags = merge(var.common_tags, var.ec2_tags,

    {
      Name = "${var.project_name}-${var.environment}-bastionhost"
    }

  )

}
