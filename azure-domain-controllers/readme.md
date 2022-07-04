## Azure Domain Controllers / Identity VNETs

The aim of this module is to provide a simple way to deploy the following elements within each required Region:

    1. A Resource Group for Identity.
    2. A KeyVault for the automatically generated Passwords - note, this is only in the Primary Region.
    3. An Availability Set for Domain Controllers.
    4. An Identity VNET and Subnet.
    5. 2x IaaS Virtual Machines to be used as Domain Controllers, each with a 20GB disk for NTSD (without caching).

To use this module, update the variables (in azuredeploy.tf) as per the below:

    ### Global Variables
    pri-location = "uksouth"              # This sets the Primary Location - this is used by the Key Vault
    dcsize       = "Standard_D2s_v4"      # This sets the Size of the VMs deployed
    dcadmin      = "vmadmin"              # This sets the admin username of the VMs deployed

Note, the VM Password is created automatically by a randomly generated string. 

### Region Specific Variables

Update the below with additional (or less) regions as required. You can add as many as required and the Module will deploy resources to each Region specified. 

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