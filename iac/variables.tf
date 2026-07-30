variable "region" {
  type        = string
  description = "Região da AWS"
  default     = "us-east-2"
}

variable "profile" {
  type        = string
  description = "Profile da AWS"
  default     = null
}
