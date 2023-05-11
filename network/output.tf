#Subnets
output "outsnPubCidr" {
  value = aws_subnet.sn_Pub.*.cidr_block
}
output "outsnAppCidr" {
  value = aws_subnet.sn_App.*.cidr_block
}
output "outsnDataCidr" {
  value = aws_subnet.sn_Data.*.cidr_block
}
