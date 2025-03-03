# variables.tf
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location/region to deploy resources"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet"
  type        = list(string)
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VM"
  type        = string
}

variable "vm_config" {
  type = map(object({
    vm_name     = string
    vm_size     = string
    install_ama = bool  # Flag to determine if AMA should be installed
    image       = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    vm_tags = map(string)
  }))
 
  default = {
    vm1 = { 
      vm_name     = "vm1"
      vm_size     = "Standard_D2s_v3"
      install_ama = false  # No AMA on this VM
      image = { 
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2022-Datacenter"
        version   = "latest"
      }
      vm_tags = { environment = "dev" }
    }
    # vm2 = { 
    #   vm_name     = "vm2"
    #   vm_size     = "Standard_D2s_v3"
    #   install_ama = true  # AMA will be installed on this VM
    #   image = { 
    #     publisher = "MicrosoftWindowsServer"
    #     offer     = "WindowsServer"
    #     sku       = "2022-Datacenter"
    #     version   = "latest"
    #   }
    #   vm_tags = { environment = "prod" }
    # }
    # vm3 = { 
    #   vm_name     = "vm3"
    #   vm_size     = "Standard_D2s_v3"
    #   install_ama = true  # AMA will be installed on this VM
    #   image = { 
    #     publisher = "MicrosoftSQLServer"
    #     offer     = "SQL2022-WS2022"
    #     sku       = "Standard"
    #     version   = "latest"
    #   }
    #   vm_tags = { environment = "test" }
    # }
  }
}