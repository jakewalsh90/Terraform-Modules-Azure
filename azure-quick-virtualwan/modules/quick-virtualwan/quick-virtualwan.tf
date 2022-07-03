# Resource Groups
resource "azurerm_resource_group" "region1-rg1" {
  name     = "${var.virtualwan-rg-name-prefix}-${var.region1}"
  location = var.region1
}
resource "azurerm_resource_group" "region2-rg1" {
  name     = "${var.virtualwan-rg-name-prefix}-${var.region2}"
  location = var.region2
}
# virtualwan
resource "azurerm_virtual_wan" "virtualwan1" {
  name                = var.virtualwan-name
  resource_group_name = azurerm_resource_group.region1-rg1.name
  location            = var.region1
  # Configuration 
  office365_local_breakout_category = "OptimizeAndAllow"
}