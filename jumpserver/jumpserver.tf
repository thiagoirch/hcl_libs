resource "aws_instance" "jumpserver" {
  ami = var.amiData
  instance_type = "t2.micro"
  subnet_id = var.snPub[0]
  key_name = var.keyPair
  security_groups = [var.sgPub]
  iam_instance_profile = var.ssmProfile
  user_data = <<-EOF
              #!/bin/bash
              yum install squid -y
              echo "http_port 8080" > /etc/squid/squid.conf
              echo "dns_nameservers 8.8.8.8" >> /etc/squid/squid.conf
              echo "acl my_lan src 10.0.0.0/8" >> /etc/squid/squid.conf
              echo "acl my_lan src 10.0.0.0/8" >> /etc/squid/squid.conf
              echo "http_access allow my_lan" >> /etc/squid/squid.conf
              echo "http_access deny all" >> /etc/squid/squid.conf
              service start start
              EOF
  tags = {
    Name = "JumpServer"
    Version = "1"
  }
}

resource "aws_eip" "jumpserver" {
  instance = aws_instance.jumpserver.id
}

output "public_ip" {
  value = aws_eip.jumpserver.public_ip
}