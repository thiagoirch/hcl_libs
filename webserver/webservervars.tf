variable "VPCIds" {}
variable "subnetApp" {}
variable "subnetPub" {
  type    = list(string)
  default = []
}
variable "sgPub" {}
variable "sgApp" {}