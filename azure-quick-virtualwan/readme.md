## Azure Virtual WAN Hubs

### ➡ Note, this is Work in Progress and will be expanded/updated in the future. 

The aim of this module is to provide a simple way to deploy the following elements within each required Region:

    1. A Resource Group for the Virtual WAN - Note this is in the Primary Region only.
    2. A Virtual WAN instance - Note, this is only in the Primary Region.
    3. A Virtual WAN hub in each region specified within the Variables.

To use this module, update the variables (in azuredeploy.tf) as per the below:

### Global Variables
    virtualwan-name = "virtualwan1"       # This sets the name of the Virtual WAN

### Region Specific Variables

Update the below (in azuredeploy.tf) with additional (or less) regions as required. You can add as many as required and the Module will deploy resources to each Region specified. 

    regions = {
        region1 = {
        location = "uksouth"
        vnetcidr = ["10.10.0.0/16"]
        snetcidr = ["10.10.1.0/24"]
        }
        region2 = {
        location = "eastus"
        vnetcidr = ["10.11.0.0/16"]
        snetcidr = ["10.11.1.0/24"]
        }
    }
