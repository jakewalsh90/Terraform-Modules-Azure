#Providers
terraform {
  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = ">= 4.37.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.1"
    }
  }
}
provider "azurerm" {
  features {
  }
}
# Modules 
module "quick-keyvault" {
  source          = "./modules/quick-keyvault"
  lz-keyvault-loc = "ukwest"
  lz-keyvault-rg  = "jwrgkv1"
}


















