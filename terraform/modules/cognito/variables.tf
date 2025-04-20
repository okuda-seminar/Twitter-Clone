variable "user_pool_name" {
  type        = string
  description = "The name of the Cognito User Pool."
}

variable "callback_urls" {
  type        = list(string)
  description = "List of allowed callback URLs after user login."
}

variable "logout_urls" {
  type        = list(string)
  description = "List of allowed logout URLs after user logout."
}

variable "env" {
  type        = string
  description = "Deployment environment name (e.g. dev, staging, prod)."
}
