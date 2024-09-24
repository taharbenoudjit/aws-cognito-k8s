variable "cluster_name" {
  type = string
}

variable "fargate_profile_name" {
  type = string
}

variable "pod_execution_role_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "namespace" {
  type = string
}
