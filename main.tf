provider "azurerm" {
  features {}
}

data "azurerm_subscription" "primary" {
}

variable "Role_NotActions" {
  type        = list(string)
  description = "list of Actions to be disallowed to custom role"
  default = []
}

variable "Role_Actions" {
  type        = list(string)
  description = "list of Actions to be allowed for custom role"
  default     = ["*"]

}

resource "azurerm_role_definition" "test_role" {
  name  = "my_custom_role"
  scope = data.azurerm_subscription.primary.id

  permissions {
    actions = [
      for string in var.Role_Actions :
      string
    ]
    not_actions = [
      for string in var.Role_NotActions :
      string
    ]
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id
  ]
}









