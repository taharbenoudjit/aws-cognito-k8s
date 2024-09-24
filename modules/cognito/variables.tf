variable "user_cognito_name" {
  type = string
}

variable "email_verification_subject" {
  type = string
}

variable "email_verification_message" {
  type = string
}

variable "pwd_minimum_length" {
  type = string
}

variable "pwd_require_lowercase" {
  type = bool
}

variable "pwd_require_numbers" {
  type = bool
}

variable "pwd_require_symbols" {
  type = bool
}

variable "pwd_require_uppercase" {
  type = bool
}

variable "email_min_length" {
  type = number
}

variable "email_max_length" {
  type = number
}

variable "username_min_length" {
  type = number
}

variable "username_max_length" {
  type = number
}

variable "user_pool_client" {
  type = string
}

variable "cognito_users" {
  type = any
}