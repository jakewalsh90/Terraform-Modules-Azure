## Work in Progress 03/07/2022

The aim of this module is to provide a simple way to deploy the following elements within each required Region:

1. A Resource Group for Identity.
2. A KeyVault for the automatically generated Passwords - note, this is only in the Primary Region.
3. An Availability Set for Domain Controllers.
4. An Identity VNET and Subnet.
5. 2x IaaS Virtual Machines to be used as Domain Controllers, each with a 20GB disk for NTSD (without caching).