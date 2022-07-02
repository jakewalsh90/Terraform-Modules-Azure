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
# Modules 
module "quick-vwan" {
  source    = "./modules/quick-vwan"
  vwan-loc1 = "uksouth"
  vwan-loc2 = "ukwest"
}