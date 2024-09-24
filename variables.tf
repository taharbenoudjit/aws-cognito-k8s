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

variable "region" {
  type = string
}

variable "website_bucket_name" {
  type = string
}

variable "logs_bucket_name" {
  type = string
}

variable "logging_bucket" {
  type = string
}

variable "logging_bucket_prefix" {
  type = string
}

variable "restriction_type" {
  type = string
}

variable "restrictions_list" {
  type = list(string)
}

variable "tags" {
  type = any
}

variable "cognito_users" {
  type = any
}

variable "rds" {
  type = any
}

variable "vpc" {
  type = any
}

variable "subnets" {
  type = any
}

variable "internet_gtw" {
  type = any
}

variable "nat_gateway" {
  type = any
}

variable "security_groups" {
  type = any
}

variable "budget" {
  type = any
}

variable "eks" {
  type = any
}

variable "kube_profile" {
  type = any
}

variable "kube_system_profile" {
  type = any
}

variable "route53" {
  type = any
}