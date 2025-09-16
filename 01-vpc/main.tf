module "vpc" {
  source               = "git::https://github.com/Siddharthasidhu666/expense_aws_vpc.git"
  cidr_block           = var.cidr_block
  common_tags          = var.common_tags
  public_cidr_blocks   = var.public_cidr_blocks
  private_cidr_blocks  = var.private_cidr_blocks
  database_cidr_blocks = var.database_cidr_blocks
  is_peering_required  = true
}
