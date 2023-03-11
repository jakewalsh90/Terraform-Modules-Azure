# Resource Groups
resource "azurerm_resource_group" "rg" {
  for_each = var.regions
  name     = "rg-identity-${each.value.location}"
  location = each.value.location
}
# KeyVault to Store VM Setup Passwords
# Create KeyVault ID
resource "random_id" "kvname" {
  byte_length = 6
  prefix      = "kv-id-"
}
# Create KeyVault
#Keyvault Creation
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "kv1" {
  name                        = random_id.kvname.hex
  location                    = var.regions.region1.location
  resource_group_name         = "rg-identity-${var.regions.region1.location}"
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
# Create KeyVault VM password
resource "random_password" "vmpassword" {
  length  = 20
  special = true
}
# Create Key Vault Secret
resource "azurerm_key_vault_secret" "vmpassword" {
  name         = "vmpassword"
  value        = random_password.vmpassword.result
  key_vault_id = azurerm_key_vault.kv1.id
  depends_on   = [azurerm_key_vault.kv1]
  content_type = "Default Password for created virtual machines"
}
# Availability Sets
resource "azurerm_availability_set" "as" {
  for_each                    = var.regions
  name                        = "as-identity-${each.value.location}"
  location                    = each.value.location
  resource_group_name         = azurerm_resource_group.rg[each.key].name
  platform_fault_domain_count = 2
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
# NICs
resource "azurerm_network_interface" "nic1" {
  for_each            = var.regions
  name                = "nic-identity-dc1-${each.value.location}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  ip_configuration {
    name                          = "ipconfig-nic1-dc1-${each.value.location}"
    subnet_id                     = azurerm_subnet.snet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "nic2" {
  for_each            = var.regions
  name                = "nic-identity-dc2${each.value.location}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  ip_configuration {
    name                          = "ipconfig-nic1-dc2-${each.value.location}"
    subnet_id                     = azurerm_subnet.snet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
# Data Disks for NTDS
resource "azurerm_managed_disk" "ntds1" {
  for_each             = var.regions
  name                 = "ntds-identity-dc1${each.value.location}"
  location             = each.value.location
  resource_group_name  = azurerm_resource_group.rg[each.key].name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = "20"
  max_shares           = "2"
}
resource "azurerm_managed_disk" "ntds2" {
  for_each             = var.regions
  name                 = "ntds-identity-dc2${each.value.location}"
  location             = each.value.location
  resource_group_name  = azurerm_resource_group.rg[each.key].name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = "20"
  max_shares           = "2"
}
# Domain Controller VMs
resource "azurerm_windows_virtual_machine" "dc1" {
  for_each            = var.regions
  name                = "vmdc1${each.value.location}"
  # Note: VM names shortened for size limits in naming. 
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  size                = var.dcsize
  admin_username      = var.dcadmin
  admin_password      = azurerm_key_vault_secret.vmpassword.value
  availability_set_id = azurerm_availability_set.as[each.key].id
  network_interface_ids = [
    azurerm_network_interface.nic1[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
resource "azurerm_windows_virtual_machine" "dc2" {
  for_each            = var.regions
  name                = "vmdc2${each.value.location}"
  # Note: VM names shortened for size limits in naming. 
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  size                = var.dcsize
  admin_username      = var.dcadmin
  admin_password      = azurerm_key_vault_secret.vmpassword.value
  availability_set_id = azurerm_availability_set.as[each.key].id
  network_interface_ids = [
    azurerm_network_interface.nic2[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
# Attach NTDS Disks
resource "azurerm_virtual_machine_data_disk_attachment" "ntds1" {
  for_each           = var.regions
  managed_disk_id    = azurerm_managed_disk.ntds1[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.dc1[each.key].id
  lun                = "10"
  caching            = "None"
}
resource "azurerm_virtual_machine_data_disk_attachment" "ntds2" {
  for_each           = var.regions
  managed_disk_id    = azurerm_managed_disk.ntds2[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.dc2[each.key].id
  lun                = "10"
  caching            = "None"
}
# Recovery Services Vault
resource "azurerm_recovery_services_vault" "rsv" {
  for_each            = var.regions
  name                = "rsv-identity-${each.value.location}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  sku                 = "Standard"
  soft_delete_enabled = true
}
# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  for_each            = var.regions
  name                = "law-identity-${each.value.location}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}