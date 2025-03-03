
resource "azurerm_network_interface" "example" {
  for_each            = var.vm_config
  name                = "${each.value.vm_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  accelerated_networking_enabled = true
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  
  }

}
# Create VM
resource "azurerm_virtual_machine" "example" {
  for_each              = var.vm_config
  name                  = each.value.vm_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [lookup(azurerm_network_interface.example, each.key, null).id]
  vm_size               = each.value.vm_size
  zones                 = [1]
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = each.value.image.publisher
    offer     = each.value.image.offer
    sku       = each.value.image.sku
    version   = each.value.image.version
  }

  storage_os_disk {
    name              = "${each.value.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = each.value.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }

  tags = each.value.vm_tags
}

# Install AMA using a Custom Script Extension
resource "azurerm_virtual_machine_extension" "ama_extension" {
  for_each             = var.vm_config
  name                 = "AMA-Agent"
  virtual_machine_id   = azurerm_virtual_machine.example[each.key].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorWindowsAgent"
  type_handler_version = "1.0"

  tags = each.value.vm_tags
}
