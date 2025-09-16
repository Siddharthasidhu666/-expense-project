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
  name = element(split(", ", "/${var.project_name}/${var.environment}/public_subnet_ids"), 0)
}


data "aws_ssm_parameter" "bastionhost" {
  name = "/${var.project_name}/${var.environment}/bastionhost"
}

