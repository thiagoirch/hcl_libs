# Main
variable "awsRegion" {
    default = "us-east-1"
}
variable "availabilityZone" {
    type = list(string)
    default = ["us-east-1a", "us-east-1b"]
}
#Network
variable "vpcCidr" {
    default = "10.1.0.0/16"
}
variable "sgData" {
    default = "data"
}
variable "sgApp" {
    default = "app"
}
variable "sgPub" {
    default = "pub"
}
variable "envName" {
    default = "Lab thiagoirch"
}
variable "cidrblocksData" {
    default = "10.1.3"
}
variable "cidrblocksApp" {
    default = "10.1.2"
}
variable "cidrblocksPub" {
    default = "10.1.1"
}
variable "dbPort" {
    default = "3306"
}
variable "httpsPort" {
    default = "80"
}