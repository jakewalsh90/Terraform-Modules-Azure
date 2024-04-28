#Providers
terraform {
  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = ">= 3.101.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.1"
    }
  }
}
provider "azurerm" {
  features {
  }
}
# Modules 
module "single-region-baselabv2" {
  source = "./modules/single-region-baselabv2"
  # Tags
  environment_tag = "jakewalsh90-baselab-v2"
  # Regional
  region1     = "uksouth"
  region1code = "uks"
  # Networking 
  # Note - changing to anything other than /19 will require checking IP ranges/addressing within the Code. 
  region1cidr = "10.10.0.0/19"
  # Identity VMs
  # Note - 1 VM is the minimum
  vmcount   = "1"
  vmsize    = "Standard_D2s_v4"
  adminuser = "labadmin"
  # Optional Features
  # Azure Bastion
  bastion = true
  # AVD Supporting Elements
  avd = true
  # Virtual Network Gateway
  vng = true
  # Firewall
  azfw = true
}


















