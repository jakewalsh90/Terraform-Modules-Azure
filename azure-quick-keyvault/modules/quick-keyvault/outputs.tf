output "azurerm_keyvault_id" {
  value = azurerm_key_vault.kv1.id
}
output "azurerm_keyvault_name" {
  value = azurerm_key_vault.kv1.name
}
output "azurerm_keyvault_vmsecret" {
  value = azurerm_key_vault_secret.vmsecret.value
  sensitive = true
}
output "azurerm_keyvault_vpnsecret" {
  value = azurerm_key_vault_secret.vpnsecret.value
  sensitive = true
}