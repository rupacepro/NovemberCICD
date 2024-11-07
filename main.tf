provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

# Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Public IP
resource "azurerm_public_ip" "example" {
  name                = "example-public-ip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"
}

# Network Interface
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  
  # Use subnet block instead of subnet_id
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id  # Corrected syntax
    private_ip_address_allocation = "Static"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

# Virtual Machine
resource "azurerm_virtual_machine" "example" {
  name                  = "example-vm"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  vm_size               = "Standard_B1ms" # Corrected argument name
  network_interface_ids = [azurerm_network_interface.example.id]
  
  os_profile {
    compute
