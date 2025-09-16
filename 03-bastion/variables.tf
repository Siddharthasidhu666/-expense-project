variable "common_tags" {
  default = {
    Project     = "expense"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "project_name" {
  default = "expense"

}



variable "environment" {
  default = "dev"

}

variable "instance_type" {
    default = "t2.micro"
  
}

variable "ec2_tags" {
    default = {}
  
}
