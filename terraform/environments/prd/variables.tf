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

variable "user_pool_name" {
  description = "Name of the Cognito User Pool"
  type        = string
}

variable "callback_urls" {
  description = "URL to redirect to after successful OAuth authentication"
  type        = list(string)
}

variable "logout_urls" {
  description = "URL to redirect to after logout"
  type        = list(string)
}

variable "region" {
  description = "The region name"
  type = string
}