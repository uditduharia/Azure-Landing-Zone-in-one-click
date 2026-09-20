terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "restart"
    storage_account_name = "ppssttoorraaggee"
    container_name       = "ppscontainer"
    key                  = "testterra.tfstate"
  }

}
provider "azurerm" {
  features {

  }

}
