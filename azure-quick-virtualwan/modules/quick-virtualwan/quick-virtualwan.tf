# Resource Groups
resource "azurerm_resource_group" "rg1" {
  name     = "rg-conn-${var.pri-location}-virtualwan"
  location = var.pri-location
}
resource "azurerm_resource_group" "rg" {
  for_each = var.regions
  name     = "rg-virtualwan-${each.value.location}"
  location = each.value.location
}
# Virtual WAN
resource "azurerm_virtual_wan" "virtualwan1" {
  name                = var.virtualwan-name
  resource_group_name = azurerm_resource_group.rg1.name
  location            = var.pri-location 
  # Configuration 
  office365_local_breakout_category = "OptimizeAndAllow"
}
# Hubs
resource "azurerm_virtual_hub" "hub" {
  for_each = var.regions
  name                = "${var.virtualwan-name}-${each.value.location}-hub-01"
  resource_group_name = azurerm_resource_group.rg[each.key].name
  location            = each.value.location
  virtual_wan_id      = azurerm_virtual_wan.virtualwan1.id
  address_prefix      = each.value.hubcidr
}