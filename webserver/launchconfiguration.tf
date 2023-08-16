resource "aws_launch_configuration" "lc_webserver" {
  name          = "ls-webserver"
  image_id      = var.amiData
  instance_type = "t3.medium"
  security_groups = [var.sgApp]
  key_name = var.keyPair
  iam_instance_profile = var.ssmProfile
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 10
    throughput            = 300
    delete_on_termination = true
  }
  user_data = <<-EOF
              #!/bin/bash
              yum install httpd -y
              echo "Hello world!"> /var/www/html/index.php
              service httpd start
              EOF
}