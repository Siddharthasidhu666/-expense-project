module "frontend" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = local.subnetid
  vpc_security_group_ids = [data.aws_ssm_parameter.frontend.value]
  create_security_group  = false
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "optional" # ✅ Allows both IMDSv1 and IMDSv2
    http_put_response_hop_limit = 8
    instance_metadata_tags      = "enabled"
  }
  tags = merge(var.common_tags, var.ec2_tags,

    {
      Name = "${var.project_name}-${var.environment}-frontend"
    }

  )

}


module "backend" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = local.private_subnetid
  vpc_security_group_ids = [data.aws_ssm_parameter.backend.value]
  create_security_group  = false
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "optional" # ✅ Allows both IMDSv1 and IMDSv2
    http_put_response_hop_limit = 8
    instance_metadata_tags      = "enabled"
  }
  tags = merge(var.common_tags, var.ec2_tags,

    {
      Name = "${var.project_name}-${var.environment}-backend"
    }

  )

}


module "ansible" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = local.subnetid
  vpc_security_group_ids = [data.aws_ssm_parameter.ansible.value]
  create_security_group  = false
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "optional" # ✅ Allows both IMDSv1 and IMDSv2
    http_put_response_hop_limit = 8
    instance_metadata_tags      = "enabled"
  }
  user_data = file("expense.sh")
  tags = merge(var.common_tags, var.ec2_tags,

    {
      Name = "${var.project_name}-${var.environment}-ansible"
    }

  )
  depends_on = [module.backend, module.frontend]

}


module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"

  zone_name = "sidthu.xyz"

  records = [
    {
      name = "frontend"
      type = "A"
      ttl  = 1
      records = [
        module.frontend.private_ip
      ]
    },
    {
      name = "backend"
      type = "A"
      ttl  = 1
      records = [
        module.backend.private_ip
      ]
    },
    {
      name = ""
      type = "A"
      ttl  = 1
      records = [
        module.frontend.public_ip
      ]
    },
  ]

}
