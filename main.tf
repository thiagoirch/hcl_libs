provider "aws" {
    region = var.awsRegion 
}
module "computeraddons"{
    source = "./computeraddons"
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
    outsnDataCidr = module.network.outsnDataCidr
    outsnAppIds = module.network.outsnAppIds
    outsnPubIds = module.network.outsnPubIds
    outsnDataIds = module.network.outsnDataIds
    
    
    #Security Group
    sgData = var.sgData
    sgApp = var.sgApp
    sgPub = var.sgPub
    httpsPort = var.httpsPort
    dbPort = var.dbPort
    outsgPubId = module.network.outsgPubId
    outsgAppId = module.network.outsgAppId
    
}
module "webserver"{
    source = "./webserver"
    VPCIds = module.network.outVPCIds
    #sgWebserver = var.outsgAppId
    snApp = module.network.outsnAppIds
    snPub = module.network.outsnPubIds
    sgPub = module.network.outsgPubId
    sgApp = module.network.outsgAppId
    keyPair = module.computeraddons.outKeypair
    ssmProfile = module.computeraddons.outssmProfile
    amiData = module.computeraddons.outAmi
}
#module "jumpserver"{
#    source = "./jumpserver"
#    keyPair = module.computeraddons.outKeypair
#    ssmProfile = module.computeraddons.outssmProfile
#    amiData = module.computeraddons.outAmi
#    snPub = module.network.outsnPubIds
#    sgPub = module.network.outsgPubId
#}