data "aws_ssm_parameter" "database" {
  name = "/${var.project_name}/${var.environment}/database"
}

data "aws_ssm_parameter" "db_subnet_group_name" {
  name = "/${var.project_name}/${var.environment}/db_subnet_group_name"
}
