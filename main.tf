provider "aws" {
    region = var.awsRegion 
}

module "network" {
    source = "./network"
    subnetAZ = var.availabilityZone
    environMent = var.envName
    #VPC
    vpcCidr = var.vpcCidr
    #Subnet
    cidrblocksData = var.cidrblocksData
    cidrblocksApp = var.cidrblocksApp
    cidrblocksPub = var.cidrblocksPub
    outsnPubCidr = module.network.outsnPubCidr
    outsnAppCidr = module.network.outsnAppCidr
    outsnAppIds = module.network.outsnAppIds
    outsnDataCidr = module.network.outsnDataCidr
    #Security Group
    sgData = var.sgData
    sgApp = var.sgApp
    sgPub = var.sgPub
    httpsPort = var.httpsPort
    dbPort = var.dbPort
}
module "webserver"{
    source = "./webserver"
    #sgWebserver = var.outsgAppId
    subNet = module.network.outsnAppIds
}