resource "aws_internet_gateway" "VPC01-igw" {
  vpc_id = aws_vpc.VPC01.id

  tags = {
    Name = "VPC01-igw"
  }
}

resource "aws_route_table" "rtpub" {
  vpc_id = aws_vpc.VPC01.id
}
resource "aws_route_table" "rtapp" {
  vpc_id = aws_vpc.VPC01.id
}
resource "aws_route_table" "rtdata" {
  vpc_id = aws_vpc.VPC01.id
}

resource "aws_route" "internet2pub" {
  route_table_id = aws_route_table.rtpub.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.VPC01-igw.id 
}
resource "aws_route" "internet2app" {
  route_table_id = aws_route_table.rtapp.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.VPC01-igw.id 
}
resource "aws_route" "internet2data" {
  route_table_id = aws_route_table.rtdata.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.VPC01-igw.id 
}

resource "aws_route_table_association" "snpubassoc" {
  count = length(var.outsnPubIds)
  subnet_id = var.outsnPubIds[count.index]
  route_table_id = aws_route_table.rtpub.id
}
resource "aws_route_table_association" "snappassoc" {
  count = length(var.outsnAppIds)
  subnet_id = var.outsnAppIds[count.index]
  route_table_id = aws_route_table.rtapp.id
}
resource "aws_route_table_association" "sndataassoc" {
  count = length(var.outsnDataIds)
  subnet_id = var.outsnDataIds[count.index]
  route_table_id = aws_route_table.rtdata.id
}