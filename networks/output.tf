output "redteam_vpc" {
  description = "The Main Analysis VPC"
  value       = aws_vpc.redteam_vpc.id
}

output "redteam_subnet" {
  description = "The Main Analysis Subnet"
  value = aws_subnet.redteam_subnet.id
}

output "redteam_subnet_cidr_prefix" {
    description = "Subnet cidr"
    value = "${var.cidr_prefix}.10"
}