resource "aws_instance" "jumpserver" {
  ami = var.amiData
  instance_type = "t2.micro"
  subnet_id = var.snPub[0]
  key_name = var.keyPair
  security_groups = [var.sgPub]
  iam_instance_profile = var.ssmProfile

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