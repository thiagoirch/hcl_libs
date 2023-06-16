data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_configuration" "lc_webserver" {
  name          = "ls-webserver"
  image_id      = data.aws_ami.amzlinux.id
  instance_type = "t3.medium"
  security_groups = [var.sgApp]
  key_name = "key_webserver"
  
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 10
    throughput            = 300
    delete_on_termination = true
  }

}