locals {
  public_subnets  = ["public_a", "public_b"]
  private_subnets = ["private_a", "private_b", "private_c"]
}

resource "aws_route_table" "public" {
  vpc_id = module.vpc["main"].vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.internet_gateway["internet"].gtw_id
  }

  tags = {
    Name = "public_route_table"
  }
}


resource "aws_route_table_association" "public" {
  count          = length(local.public_subnets)
  subnet_id      = module.subnet[local.public_subnets[count.index]].subnet_id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private" {
  vpc_id = module.vpc["main"].vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = module.nat_gateway["main"].nat_gtw_id
  }

  tags = {
    Name = "private-table"
  }
}


resource "aws_route_table_association" "private" {
  count          = length(local.private_subnets)
  subnet_id      = module.subnet[local.private_subnets[count.index]].subnet_id
  route_table_id = aws_route_table.private.id
}