output "az_info" {
  value = module.vpc.azs.names

}

output "vpc_id" {
  value = module.vpc.vpc_id

}
