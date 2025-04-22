variable "env" {
  description = "The environment name."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instance will be created."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet within the specified VPC where the EC2 instance will be launched."
  type        = string
}
