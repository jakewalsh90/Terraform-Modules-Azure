#Providers
terraform {
  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = ">= 4.15.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.3"
    }
  }
}
provider "azurerm" {
  features {
  }
}
# Modules 
module "quick-virtualwan" {
  source = "./modules/quick-virtualwan"
  # Global Variables
  virtualwan-name = "virtualwan1"
  # Region Specific Variables
  regions = {
    region1 = {
      location = "uksouth"
      hubcidr  = "10.10.0.0/21"
    }
    region2 = {
      location = "eastus"
      hubcidr  = "10.20.0.0/21"
    }
  }
}


















