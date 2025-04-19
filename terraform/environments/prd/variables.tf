variable "profile" {
  description = "The AWS profile to use for authentication"
  type        = string
  default     = ""
}

variable "env" {
  description = "The environment name"
  type        = string
  default     = "prd"
}