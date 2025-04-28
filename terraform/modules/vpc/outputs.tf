output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The public subnet ID"
  value       = aws_subnet.public.id
}
