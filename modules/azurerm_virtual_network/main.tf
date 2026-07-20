resource "azurerm_network_security_group" "nsg" {

    for_each = var.virtualnet
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  
}



resource "azurerm_virtual_network" "vnet" {

    for_each = var.virtualnet

      name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  
}