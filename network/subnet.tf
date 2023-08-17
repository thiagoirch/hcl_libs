resource "aws_subnet" "sn_Data" {
  vpc_id = aws_vpc.VPC01.id
  count = length(var.subnetAZ) 
  cidr_block = "${var.cidrblocksData}${count.index}.0/24"
  availability_zone = var.subnetAZ[count.index] 
}
resource "aws_subnet" "sn_App" {
  count = length(var.subnetAZ) 
  vpc_id = aws_vpc.VPC01.id
  cidr_block = "${var.cidrblocksApp}${count.index}.0/24"
  availability_zone = var.subnetAZ[count.index]
  map_public_ip_on_launch = false
}

resource "aws_subnet" "sn_Pub" {
  vpc_id = aws_vpc.VPC01.id
  count = length(var.subnetAZ) 
  cidr_block = "${var.cidrblocksPub}${count.index}.0/24"
  availability_zone = var.subnetAZ[count.index]
  map_public_ip_on_launch = false
}