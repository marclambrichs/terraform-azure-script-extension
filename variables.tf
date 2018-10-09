variable "commands" {
  description = "Command that will be executed."
  default     = ""
}

variable "location" {
  description = "The location of the network where the VM is going to be created in."
  default     = ""
}

variable "name" {
  description = "The name of the vms the extension will be attached to"
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  default     = "terraform-compute"
}

variable "tags" {
  type        = "map"
  description = "Tags to attach to this resource."
  default     = {}
}

variable "urls" {
  type        = "list"
  description = "List of urls where to find the scripts to execute."
  default     = []
}

variable "virtual_machines" {
  type        = "list"
  description = "List of vms where this extension needs to be attached to."
  default     = []
}
