terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-common"
    storage_account_name = "sttfstatecommon1234"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
  }
}
