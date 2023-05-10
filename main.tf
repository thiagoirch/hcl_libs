provider "aws" {
    region = var.awsRegion 
}

module "network" {
    source = "./network"
    vpcCidr = var.vpcCidr
    cidrblocksData = var.cidrblocksData
    cidrblocksApp = var.cidrblocksApp
    cidrblocksPub = var.cidrblocksPub
    subnetAZ = var.availabilityZone
    environMent = var.envName
    sgData = var.sgData
    sgApp = var.sgApp
    sgPub = var.sgPub
}