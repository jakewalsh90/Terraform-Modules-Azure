# Resource Groups
resource "azurerm_resource_group" "region1-rg1" {
  name     = "${var.virtualwan-rg-name-prefix}-${var.loc1 }"
  location = var.loc1 
}
resource "azurerm_resource_group" "region2-rg1" {
  name     = "${var.virtualwan-rg-name-prefix}-${var.loc2}"
  location = var.loc2
}
# Virtual WAN
resource "azurerm_virtual_wan" "virtualwan1" {
  name                = var.virtualwan-name
  resource_group_name = azurerm_resource_group.region1-rg1.name
  location            = var.loc1 
  # Configuration 
  office365_local_breakout_category = "OptimizeAndAllow"
}
# Virtual WAN Hub 1
resource "azurerm_virtual_hub" "region1-vhub1" {
  name                = "${var.virtualwan-name}-${var.loc1 }-hub-01"
  resource_group_name = azurerm_resource_group.region1-rg1.name
  location            = var.loc1 
  virtual_wan_id      = azurerm_virtual_wan.virtualwan1.id
  address_prefix      = var.loc1-hub-cidr
}
# Virtual WAN Hub 2
resource "azurerm_virtual_hub" "region2-vhub1" {
  name                = "${var.virtualwan-name}-${var.loc1 }-hub-01"
  resource_group_name = azurerm_resource_group.region2-rg1.name
  location            = var.loc2
  virtual_wan_id      = azurerm_virtual_wan.virtualwan1.id
  address_prefix      = var.loc2-hub-cidr
}