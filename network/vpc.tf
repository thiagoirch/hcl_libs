resource "aws_vpc" "VPC01" {
  cidr_block = var.vpcCidr
  tags = {
    Name = "vpc-${var.environMent}"
  }
}