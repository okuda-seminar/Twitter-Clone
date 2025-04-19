variable "profile" {
  description = "The AWS profile to use for authentication"
  type        = string
}

variable "env" {
  description = "The environment name"
  type        = string
  default     = "prd"
}

variable "account_id" {
  description = "The AWS account ID"
  type        = string
}
