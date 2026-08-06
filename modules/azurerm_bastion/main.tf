
data "azurerm_subnet" "subnet" {

    for_each = var.bastionblock

     name                 = each.value.bastion_subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
  
}

data "azurerm_public_ip" "public_ip" {

    for_each = var.bastionblock

     name                = each.value.bastion_pip_name
  resource_group_name = each.value.resource_group_name
  
  
}


resource "azurerm_bastion_host" "bastionblock" {

    for_each = var.bastionblock

      name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "bastionconfiguration"
    subnet_id            = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.public_ip[each.key].id
  }
}
  
