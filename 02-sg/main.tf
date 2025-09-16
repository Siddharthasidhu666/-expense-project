module "database" {
  source      = "../../expense_aws_sg"
  sg_name     = "database"
  common_tags = var.common_tags
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  description = "its fpr database"


}

module "backend" {
  source      = "../../expense_aws_sg"
  sg_name     = "backend"
  common_tags = var.common_tags
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  description = "its for backend"


}


module "frontend" {
  source      = "../../expense_aws_sg"
  sg_name     = "frontend"
  common_tags = var.common_tags
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  description = "its for frontend"


}

module "bastionhost" {
  source      = "../../expense_aws_sg"
  sg_name     = "bastionhost"
  common_tags = var.common_tags
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  description = "its for bastionhost"


}


module "ansible" {
  source      = "../../expense_aws_sg"
  sg_name     = "ansible"
  common_tags = var.common_tags
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  description = "its for ansible"


}




