resource "aws_key_pair" "key_webserver" {
  key_name   = "key-webserver"
  public_key = file("~/.ssh/id_rsa.pub")
}
