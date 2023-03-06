#Providers
terraform {
  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = ">= 3.46.0"
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
# Module Configuration
module "identity-resources" {
  source = "./modules/identity-resources"
  # Global Variables
  pri-location = "uksouth"
  dcsize       = "Standard_D2s_v4"
  dcadmin      = "vmadmin"
  # Region Specific Variables
  regions = {
    region1 = {
      location = "uksouth"
      vnetcidr = ["10.10.0.0/16"]
      snetcidr = ["10.10.1.0/24"]
    }
  }
}
