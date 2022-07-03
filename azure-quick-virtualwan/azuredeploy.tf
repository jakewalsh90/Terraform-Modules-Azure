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
module "quick-virtualwan" {
  source                    = "./modules/quick-virtualwan"
  loc1                      = "uksouth"
  loc2                      = "ukwest"
  virtualwan-rg-name-prefix = "rg-conn-"
  virtualwan-name           = "virtualwan"
  loc1-hub-cidr             = "10.10.0.0/21"
  loc2-hub-cidr             = "10.20.0.0/21"
}