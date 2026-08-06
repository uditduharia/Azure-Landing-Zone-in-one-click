data "azurerm_subnet" "subnet" {

    for_each = var.appgwblock

     name                 = each.value.app_gateway_subnetname
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
  
}

data "azurerm_public_ip" "public_ip" {

    for_each = var.appgwblock

     name                = each.value.app_gateway_pip_name
  resource_group_name = each.value.resource_group_name
  
  
}



resource "azurerm_application_gateway" "appgwblock" {

    for_each = var.appgwblock

    name                = each.value.name_appgw
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  sku {
    name     = each.value.name_sku
    tier     = each.value.tier
    capacity = each.value.capacity
  }

  gateway_ip_configuration {
    name      = each.value.name_appgw_ip_config
    subnet_id = data.azurerm_subnet.subnet[each.key].id
  }

  frontend_port {
    name = each.value.frontend_port_name
    port = each.value.port
  }

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_configuration_name
    public_ip_address_id          = data.azurerm_public_ip.public_ip[each.key].id
  }

  backend_address_pool {
    name = each.value.backend_address_pool_name
  }

  backend_http_settings {
    name                  = each.value.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = each.value.listener_name
    frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
    frontend_port_name             = each.value.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = each.value.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = each.value.listener_name
    backend_address_pool_name  = each.value.backend_address_pool_name
    backend_http_settings_name = each.value.http_setting_name
  }
}

    
