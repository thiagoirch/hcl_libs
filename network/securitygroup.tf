resource "aws_security_group" "sg-Pub" {
    name = "SG-${var.sgPub}-${var.environMent}"
    vpc_id = aws_vpc.VPC01.id
    
    ingress {
      from_port = var.httpsPort
      to_port = var.httpsPort
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
     }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}
resource "aws_security_group" "sg-app" {
    name = "SG-${var.sgApp}-${var.environMent}"
    vpc_id = aws_vpc.VPC01.id
    
    dynamic "ingress" {
      for_each = var.outsnPubCidr
      content {
        from_port = 0
        to_port = 0
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
resource "aws_security_group" "sg-data" {
    name = "SG-${var.sgData}-${var.environMent}"
    vpc_id = aws_vpc.VPC01.id
    
    dynamic "ingress" {
      for_each = var.outsnAppCidr
      content {
        from_port = var.dbPort
        to_port = var.dbPort
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

