# Terraform-Modules

[![Check Links](https://github.com/jakewalsh90/Terraform-Modules-Azure/actions/workflows/links.yml/badge.svg)](https://github.com/jakewalsh90/Terraform-Modules-Azure/actions/workflows/links.yml)

This repository contains Terraform Modules I have created for Azure. Feel free to use these as you wish! 😄

## How to Deploy

### :heavy_check_mark: Install the Right Tools First!

I have setup a Chocolatey script that will provide all the tools you need to work with Terraform on Azure - see [here](https://github.com/jakewalsh90/Terraform-Azure/blob/main/Chocolatey-Setup/TerraformApps.ps1).

### :arrow_right: GitHub Actions or Manual Deployment?

These projects can be deployed easily either Manually or using GitHub Actions - for a full guide, please see [here](https://github.com/jakewalsh90/Terraform-Azure/tree/main/GitHub-Actions-Deployment).

If you are new to Terraform, please check out my Getting Started with Azure Terraform Blog Series [here](https://jakewalsh.co.uk/category/terraform-getting-started/)

## :question: Want to see new Projects in this Repository?

Please reach out to me via my Website or Twitter - I am happy to create new projects or collaborate!

## :question: Found an issue or Bug? 

Please open an issue, or feel free to create a pull request. You can also reach out to me via my Website or Twitter! :)

## :heavy_check_mark: Projects in this Repository

### 1. **Azure Quick KeyVault**
*This creates a simple KeyVault setup that includes a Resource Group, Key Vault, and a number of secure secrets that can be used in your deployments.* **See: [Azure Quick Key Vault](https://github.com/jakewalsh90/Terraform-Modules/tree/main/azure-quick-keyvault)**

### 2. **Azure Quick Virtual WAN**
*This creates a simple Azure Virtual WAN environment that can be used for Labs/Testing and learning about Virtual WAN.* **See: [Azure Quick Virtual WAN](https://github.com/jakewalsh90/Terraform-Modules/tree/main/azure-quick-virtualwan)**

### 3. **Azure Identity Resources**
*This module creates a number of identity resources across Azure regions using a Map Variable. You can use this module to add identity Resources to whichever Regions you require easily.* **See: [Azure Identity Resources](https://github.com/jakewalsh90/Terraform-Modules/tree/main/azure-identity-resources)**

### 4. **Single Region Base Lab Environment for Azure - V2**
*Updated from my Single Region Azure Base Lab - This V2 version creates a simple Lab environment within a Single Azure Region. The idea here is that it allows for quick deployment of VNETs, Subnets, Domain Controller/Additional VMs to simulate smaller environments or provide a quick lab for any test requirements. Now includes optional features, enabled/disabled via Variables; Azure Bastion, Azure Firewall, AVD Supporting Elements, and a Virtual Network Gateway.* **See: [Azure Single Region Base Lab V2](https://github.com/jakewalsh90/Terraform-Modules-Azure/tree/main/azure-single-region-baselabv2).**