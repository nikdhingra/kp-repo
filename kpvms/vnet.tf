resource "azurerm_resource_group" "example" {
  name =  var.resource_group_name
  location = var.location
}

# Create VNET
resource "azurerm_virtual_network" "example"{
  name                = var.vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = var.vnet_address_space
}

# Create Subnet
resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.subnet_address_prefix
  depends_on = [ azurerm_virtual_network.example ]
}