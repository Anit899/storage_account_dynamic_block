variable "app-code" {}
variable "ips_allowed" {}


resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.app-code}"
  location = "West Europe"
}

resource "azurerm_storage_account" "stg" {
  name                = "anitstg01"
  resource_group_name = azurerm_resource_group.rg.name

  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  dynamic "network_rules" {
    for_each = var.ips_allowed == null ? [] : [12]
    content {
      default_action = "Deny"
      ip_rules       = var.ips_allowed

    }
  }
}



