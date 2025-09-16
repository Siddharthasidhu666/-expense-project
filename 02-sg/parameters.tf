resource "aws_ssm_parameter" "database" {
  name  = "/${var.project_name}/${var.environment}/database"
  type  = "String"
  value = module.database.sg_id
}

resource "aws_ssm_parameter" "frontend" {
  name  = "/${var.project_name}/${var.environment}/frontend"
  type  = "String"
  value = module.frontend.sg_id
}



resource "aws_ssm_parameter" "backend" {
  name  = "/${var.project_name}/${var.environment}/backend"
  type  = "String"
  value = module.backend.sg_id
}


resource "aws_ssm_parameter" "bastionhost" {
  name  = "/${var.project_name}/${var.environment}/bastionhost"
  type  = "String"
  value = module.bastionhost.sg_id
}

resource "aws_ssm_parameter" "ansible" {
  name  = "/${var.project_name}/${var.environment}/ansible"
  type  = "String"
  value = module.ansible.sg_id
}

resource "aws_security_group_rule" "database_backend" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.backend.sg_id # source is where you are getting traffic from
  security_group_id        = module.database.sg_id
}

resource "aws_security_group_rule" "database_bastionhost" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.bastionhost.sg_id # source is where you are getting traffic from
  security_group_id        = module.database.sg_id
}

#################################################################
resource "aws_security_group_rule" "backend_frontend" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id # source is where you are getting traffic from
  security_group_id        = module.backend.sg_id
}

resource "aws_security_group_rule" "backend_bastionhost" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastionhost.sg_id # source is where you are getting traffic from
  security_group_id        = module.backend.sg_id
}

resource "aws_security_group_rule" "backend_ansible" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.ansible.sg_id # source is where you are getting traffic from
  security_group_id        = module.backend.sg_id
}


#########################################################################

resource "aws_security_group_rule" "frontend_public" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  #source_security_group_id = module.frontend.sg_id # source is where you are getting traffic from
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "frontend_ansible" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.ansible.sg_id
  security_group_id        = module.frontend.sg_id
}

resource "aws_security_group_rule" "frontend_bastionhost" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastionhost.sg_id
  security_group_id        = module.frontend.sg_id
}

############################################################################

resource "aws_security_group_rule" "bastionhost_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastionhost.sg_id
}

################################################################
resource "aws_security_group_rule" "ansible_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.ansible.sg_id
}
