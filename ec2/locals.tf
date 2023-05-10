locals {
  commonTags = {
    Name = var.instanceName
    Environment = var.environMent
    Owner = "Recife"
    ManagedBy = "Terraform"
  }
}