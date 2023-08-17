resource "aws_security_group" "sg-Pub" {
    name = "SG-${var.sgPub}-${var.environMent}"
    vpc_id = aws_vpc.VPC01.id
    
    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
     }
     ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
     }
     ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
     }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "sg-App" {
    name = "SG-${var.sgApp}-${var.environMent}"
    vpc_id = aws_vpc.VPC01.id
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
     }
    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
     }
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
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "sg-Data" {
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
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

