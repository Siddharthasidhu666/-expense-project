data "aws_ssm_parameter" "frontend" {
  name = "/${var.project_name}/${var.environment}/frontend"
}


data "aws_ssm_parameter" "backend" {
  name = "/${var.project_name}/${var.environment}/backend"
}

data "aws_ssm_parameter" "ansible" {
  name = "/${var.project_name}/${var.environment}/ansible"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["973714476881"]
}


data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}
