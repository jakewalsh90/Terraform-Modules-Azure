This module creates an Azure KeyVault and a number of secrets. It is designed to be a quick addition to environments to allow rapid provisioning of common secure strings required. 

What this module creates:

1. A Resource Group named using the "lz-keyvault-rg" input variable. 
2. A Key Vault named using a "kv" prefix and then a randomised 16 character string. 
3. All Resources are located based on the "lz-keyvault-loc" input variable. 
4. The following secrets are created based on random strings for quick lab use:

    1. vmsecret - for VM passwords. Refer to this output using module.quick-keyvault.azurerm_keyvault_vmsecret
    2. vpnsecret- for VPN connections. Refer to this output using module.quick-keyvault.azurerm_keyvault_vpnsecret

Note: Purge protection is disabled in the module by default (for lab environments). In production you are likely to want this enabled. Change "purge_protection_enabled" to true in line 20 of quick-keyvault.tf. 