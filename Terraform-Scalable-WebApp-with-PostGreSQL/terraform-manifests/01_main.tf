# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# Provider Block
provider "azurerm" {
  features {}
}

# Create the resoure group for the resources
resource "azurerm_resource_group" "resource_group" {
  name     = "${var.environment}-${var.resource_group_name}"
  location = var.resource_location

}

# Creates the virtual network for the resources
resource "azurerm_virtual_network" "vnet1" {

  name                = "${var.environment}-${var.VirtualNetwork}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = var.VirtualNetwork_AddressSpace
}


# Create the default subnet for the vnet
resource "azurerm_subnet" "subnet-default" {

  name                 = "snet-teva-${count.index}"
  count                = length(var.subnet_prefix)
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.subnet_prefix[count.index]]
}