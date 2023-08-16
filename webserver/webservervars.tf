variable "VPCIds" {}
variable "snApp" {
  type    = list(string)
  default = []
}
variable "snPub" {
  type    = list(string)
  default = []
}
variable "sgPub" {}
variable "sgApp" {}
variable "keyPair" {}
variable "ssmProfile" {}
variable "amiData" {}