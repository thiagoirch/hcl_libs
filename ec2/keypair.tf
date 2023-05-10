resource "aws_key_pair" "labpub" {
  key_name   = var.keyName
  public_key = var.pubKey
  tags = local.commonTags
}