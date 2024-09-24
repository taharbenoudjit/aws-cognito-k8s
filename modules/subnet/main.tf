resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = var.is_public_subnet
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  tags = var.tags
}

