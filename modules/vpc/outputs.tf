
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.demo_vpc.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.demo_public_subnet.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.demo_private_subnet.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.demo_igw.id
}

output "availability_zone" {
  description = "Availability zone used"
  value       = local.az
}
