#VPC
 #VPC-ID
output "outVPCIds" {
  value = aws_vpc.VPC01.id
}

#Subnets
 #ID
output "outsnPubIds" {
  value = aws_subnet.sn_Pub.*.id
}
output "outsnAppIds" {
  value = aws_subnet.sn_App.*.id
}
output "outsnDataIds" {
  value = aws_subnet.sn_Data.*.id
}
 #Cidr
output "outsnPubCidr" {
  value = aws_subnet.sn_Pub.*.cidr_block
}
output "outsnAppCidr" {
  value = aws_subnet.sn_App.*.cidr_block
}
output "outsnDataCidr" {
  value = aws_subnet.sn_Data.*.cidr_block
}

#Security Group
output "outsgPubId" {
  value = aws_security_group.sg-Pub.id
}
output "outsgAppId" {
  value = aws_security_group.sg-App.id
}
output "outsgDataId" {
  value = aws_security_group.sg-Data.id
}
