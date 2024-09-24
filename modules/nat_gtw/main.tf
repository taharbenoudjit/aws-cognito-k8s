resource "aws_eip" "gw" {
  domain       = "vpc"  
}

resource "aws_nat_gateway" "gw" {
  subnet_id     = var.subnet_id
  allocation_id = aws_eip.gw.id

  tags = {
    Name = var.name
  }
}