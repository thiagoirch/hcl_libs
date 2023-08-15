resource "aws_internet_gateway" "VPC01-igw" {
  vpc_id = aws_vpc.VPC01.id

  tags = {
    Name = "VPC01-igw"
  }
}

resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.VPC01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.VPC01-igw.id
  }
}

resource "aws_route_table_association" "rta-public" {
  count          = 2
  subnet_id      = aws_subnet.sn_Pub[count.index].id
  route_table_id = aws_route_table.rt-public.id
}