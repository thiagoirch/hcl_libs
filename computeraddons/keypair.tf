resource "aws_key_pair" "masterkeypair" {
  key_name   = "masterkeypair"
  public_key = file("~/.ssh/id_rsa.pub")
}
