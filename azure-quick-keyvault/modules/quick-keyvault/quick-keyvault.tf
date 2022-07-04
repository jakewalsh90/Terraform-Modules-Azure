#Resource Groups
resource "azurerm_resource_group" "rg1" {
  name     = var.lz-keyvault-rg
  location = var.lz-keyvault-loc
}
#Create KeyVault ID
resource "random_id" "kvname" {
  byte_length = 8
  prefix      = "kv-"
}
#Keyvault Creation
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "kv1" {
  name                        = random_id.kvname.hex
  location                    = var.lz-keyvault-loc
  resource_group_name         = azurerm_resource_group.rg1.name
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
#Create vmsecret
resource "random_password" "vmsecret" {
  length  = 20
  special = true
}
#Create vmsecret in KV
resource "azurerm_key_vault_secret" "vmsecret" {
  name         = "vmsecret"
  value        = random_password.vmsecret.result
  key_vault_id = azurerm_key_vault.kv1.id
  depends_on   = [azurerm_key_vault.kv1]
  content_type = "Default VM Password"
}
#Create vpnsecret
resource "random_password" "vpnsecret" {
  length  = 20
  special = false
}
#Create vpnsecret in KV
resource "azurerm_key_vault_secret" "vpnsecret" {
  name         = "vpnsecret"
  value        = random_password.vpnsecret.result
  key_vault_id = azurerm_key_vault.kv1.id
  depends_on   = [azurerm_key_vault.kv1]
  content_type = "VPN Secret"
}