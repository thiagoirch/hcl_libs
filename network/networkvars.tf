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
#Security Groups
variable "sgData" {}
variable "sgApp"{}
variable "sgPub" {}