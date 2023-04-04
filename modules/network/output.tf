output "vpc" {
  value = aws_vpc.vpc
}

output "gw" {
  value = aws_internet_gateway.gw
}

output "gw_table_route" {
  value = aws_route_table.table_route
}