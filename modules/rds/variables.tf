variable "cluster_identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "database_name" {
  type = string
}

variable "master_username" {
  type = string
}

variable "master_password" {
  type = string
}

variable "backup_retention_period" {
  type = number
  default = 1
}

variable "preferred_backup_window" {
  type = string
  default = ""
}

variable "instance_count" {
  type = number
}

variable "instance_name" {
  type = string
}

variable "insatnce_class" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}