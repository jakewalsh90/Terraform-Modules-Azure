#Providers
terraform {
  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = ">= 3.41.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.3"
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
  pri-location    = "uksouth"
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
