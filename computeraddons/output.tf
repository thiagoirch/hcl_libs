#AMI
output "outAmi" {
    value = "ami-08a52ddb321b32a8c"
}
#SSM
output "outssmProfile" {
    value = aws_iam_instance_profile.ssmProfile.name
}
#keypair
output "outKeypair" {
  value = aws_key_pair.masterkeypair.key_name
}