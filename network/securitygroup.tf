resource "aws_security_group" "sg-app" {
    name = "SG-${var.sgApp}-${var.environMent}"
    vpc_id = aws_vpc.VPC01.id
    
    dynamic "ingress" {
      for_each = var.outsnPubCidr
      content {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ingress.value]
     }
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}