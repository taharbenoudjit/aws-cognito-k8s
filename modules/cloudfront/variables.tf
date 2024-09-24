variable "origin_bucket_domaine_name" {
  type = string
}

variable "origin_bucket_id" {
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

variable "route53_zone_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "cert_domain" {
  type = string
}