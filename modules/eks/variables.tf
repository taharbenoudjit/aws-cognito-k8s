variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "public_access_cidrs" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_groups_id" {
  type = list(string)
}

variable "enabled_cluster_log_types" {
  type =  list(string)
}

variable "kms_arn" {
  type = string
}


