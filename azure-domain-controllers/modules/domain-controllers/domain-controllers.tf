# Resource Groups
resource "azurerm_resource_group" "rg" {
  for_each = var.regions
  name     = "rg-identity-${each.value.location}"
  location = each.value.location
}
resource "azurerm_resource_group" "rg-kv" {
  name     = "rg-identity-kv-${var.pri-location}"
  location = var.pri-location
}
# KeyVault to Store VM Setup Passwords
# Create KeyVault ID
resource "random_id" "kvname" {
  byte_length = 8
  prefix      = "kv-"
}
# Create KeyVault
#Keyvault Creation
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "kv1" {
  name                        = random_id.kvname.hex
  location                    = var.pri-location
  resource_group_name         = azurerm_resource_group.rg-kv.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}
# Availability Sets
resource "azurerm_availability_set" "as" {
  for_each            = var.regions
  name                = "as-identity-${each.value.location}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.key].name
}
# Virtual Networks
resource "azurerm_virtual_network" "vnet" {
  for_each            = var.regions
  name                = "vnet-identity-${each.value.location}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  address_space       = each.value.vnetcidr
}
# Subnets
resource "azurerm_subnet" "snet" {
  for_each             = var.regions
  name                 = "subnet-identity-${each.value.location}"
  resource_group_name  = azurerm_resource_group.rg[each.key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = each.value.snetcidr
}
# NSG
resource "azurerm_network_security_group" "nsg" {
  for_each            = var.regions
  name                = "nsg-identity-${each.value.location}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.key].name
}
# NSG Association
resource "azurerm_subnet_network_security_group_association" "nsga" {
  for_each                  = var.regions
  subnet_id                 = azurerm_subnet.snet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}