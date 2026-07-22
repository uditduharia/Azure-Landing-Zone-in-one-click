data "azurerm_subnet" "subnet" {

    for_each = var.virtual_machine

     name                 = each.value.nic_subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
  
}

data "azurerm_public_ip" "public_ip" {

    for_each = var.virtual_machine

     name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
  
  
}


resource "azurerm_network_interface" "nicblock" {

    for_each = var.virtual_machine
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  

  ip_configuration {
    name                          = each.value.ip_config_name
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id          = data.azurerm_public_ip.public_ip[each.key].id
    private_ip_address_allocation = "static"
  }
}

resource "azurerm_linux_virtual_machine" "vmblock" {

    for_each = var.virtual_machine
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  
  disable_password_authentication = false
  
  network_interface_ids = [
    azurerm_network_interface.nicblock[each.key].id,
  ]

  



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}