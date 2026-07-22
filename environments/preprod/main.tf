module "rg" {
  source = "../../modules/azurerm_resource_group"

  resourcegrp = var.rgs

}

module "vnet" {
  source = "../../modules/azurerm_virtual_network"

  virtualnet = var.vnets

  depends_on = [
    module.rg
  ]

}

module "subnets" {
  source         = "../../modules/azurerm_subnet"
  azurerm_subnet = var.subnets

  depends_on = [
    module.rg,
    module.vnet
  ]

}

module "public_ip" {
  source = "../../modules/azurerm_public_ip"
  pub_ip = var.public_ips

  depends_on = [
    module.rg
  ]

}

module "vm" {

  source          = "../../modules/azurerm_virtual_machine"
  virtual_machine = var.vms

  depends_on = [
    module.subnets,
    module.public_ip
  ]

}

# module "bastion" {

#     source = "../../modules/azurerm_bastion"
#     bastionblock = var.azure_bastion

#      depends_on = [
#       module.subnets,
#       module.public_ip
#     ]

# }