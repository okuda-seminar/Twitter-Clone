output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.main.id
}

output "private_subnet_id" {
  description = "The private subnet ID"
  value       = aws_subnet.private.id
}
