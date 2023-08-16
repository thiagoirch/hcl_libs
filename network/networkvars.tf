#Main
variable "subnetAZ" {}
variable "environMent" {}
#VPC
variable "vpcCidr" {}
#Subnets
variable "cidrblocksData" {}
variable "cidrblocksApp" {}
variable "cidrblocksPub" {}
variable "outsnPubCidr" {}
variable "outsnAppCidr" {}
variable "outsnDataCidr" {}
variable "outsnAppIds" {}
variable "outsnPubIds" {}
variable "outsnDataIds" {}
#Security Groups
variable "sgData" {}
variable "sgApp"{}
variable "sgPub" {}
variable "dbPort" {}
variable "httpsPort" {}
variable "outsgPubId" {}
variable "outsgAppId" {}
