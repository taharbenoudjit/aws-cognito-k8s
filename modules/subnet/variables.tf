variable "availability_zone" {
  description = "availability zone"
  type        = string
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}


variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}


variable "is_public_subnet" {
  description = "If the value is set to true, the subnet will have public access"
  type        = bool
}

variable "tags" {
  type = any
}
