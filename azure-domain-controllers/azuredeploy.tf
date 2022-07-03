#Providers
terraform {
  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = ">= 3.12.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.3.2"
    }
  }
}
provider "azurerm" {
  features {
  }
}
# Module Configuration
module "domain-controllers" {
  source       = "./modules/domain-controllers"
  pri-location = "uksouth"
  dcsize       = "Standard_D2s_v4"
  dcadmin      = "vmadmin"
  regions = {
    region1 = {
      location = "uksouth"
      vnetcidr = ["10.10.0.0/16"]
      snetcidr = ["10.10.1.0/24"]
    }
    region2 = {
      location = "ukwest"
      vnetcidr = ["10.11.0.0/16"]
      snetcidr = ["10.11.1.0/24"]
    }
  }
}