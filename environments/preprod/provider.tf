terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-prod"
    storage_account_name = "ppsstorageee"
    container_name       = "tfstate"
    key                  = "thisterraform.tfstate"
  }

}
provider "azurerm" {
  features {

  }

}