data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_configuration" "lc_webserver" {
  name          = "ls-webserver"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.medium"
  security_groups = [var.sgApp]
  key_name = aws_key_pair.key_webserver.key_name
  
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 10
    throughput            = 300
    delete_on_termination = true
  }

}