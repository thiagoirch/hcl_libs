resource "aws_vpc" "VPC01" {
  cidr_block = var.vpcCidr
  tags = {
    Name = "vpc-${var.environMent}"
  }
}

resource "aws_subnet" "sn_data" {
  vpc_id = aws_vpc.VPC01.id
  count = length(var.subnetAZ) 
  cidr_block = "${var.cidrblocksData}${count.index}.0/24"
  availability_zone = var.subnetAZ[count.index] 
}
resource "aws_subnet" "sn_app" {
  count = length(var.subnetAZ) 
  vpc_id = aws_vpc.VPC01.id
  cidr_block = "${var.cidrblocksApp}${count.index}.0/24"
  availability_zone = var.subnetAZ[count.index] 
}

resource "aws_subnet" "sn_Pub" {
  vpc_id = aws_vpc.VPC01.id
  count = length(var.subnetAZ) 
  cidr_block = "${var.cidrblocksPub}${count.index}.0/24"
  availability_zone = var.subnetAZ[count.index] 
  
}
resource "aws_security_group" "sg-app" {
    name = "SG-${var.securityGroupApp}-${var.environMent}"
    vpc_id = aws_vpc.VPC01.id
    ingress { 
      from_port = 0
      to_port = 443
      protocol = "tcp"
      cidr_blocks = aws_subnet.sn_Pub.cidr_block
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}