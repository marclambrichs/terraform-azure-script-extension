provider "azurerm" {
  version = ">= 1.1.0"
}

provider "random" {
  version = "~> 1.0"
}

##################################################
# Use Custom Script Extension
##################################################
resource "azurerm_virtual_machine_extension" "vm_ext" {
  count                = "${length(var.virtual_machines)}"
  name                 = "custom_extension-${var.name}-${count.index}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_machine_name = "${element(var.virtual_machines,count.index)}"

  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
  {
    "fileUris": ["${join("\",\"", var.urls)}"],
    "commandToExecute": "${var.commands}"
  }
SETTINGS

  tags = "${var.tags}"
}
