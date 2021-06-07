resource "azurerm_virtual_wan" "main" {
  name                = var.name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  allow_branch_to_branch_traffic = var.allow_branch_to_branch_traffic
}

resource "azurerm_virtual_hub" "main" {
  #for_each            = { for hub in var.hubs : hub.region => hub }
  name                = "gcto-blueprints-sandpit-vwan-hub"
  resource_group_name = azurerm_virtual_wan.main.resource_group_name
  location            = azurerm_virtual_wan.main.location
  virtual_wan_id      = azurerm_virtual_wan.main.id
  address_prefix      = var.wan-prefix
}

resource "azurerm_virtual_hub_connection" "main" {
  #for_each                  = { for c in local.connections : c.id => c }
  name                      = "gcto-blueprints-sandpit-vwan-hub-connection"
  virtual_hub_id            = azurerm_virtual_hub.main.id
  remote_virtual_network_id = azurerm_virtual_network.main.id
}

resource "azurerm_network_security_group" "main" {
  name                = "gcto-blueprints-network-eus2-nsg"
  location            = azurerm_virtual_wan.main.location
  resource_group_name = azurerm_virtual_wan.main.resource_group_name
}

resource "azurerm_virtual_network" "main" {
  name                = "gcto-blueprints-network-eus2-vnet"
  location            = azurerm_virtual_wan.main.location
  resource_group_name = azurerm_virtual_wan.main.resource_group_name
  address_space       = ["10.2.0.0/22"]
  
  
  subnet {
    name           = "default"
    address_prefix = "10.2.0.0/24"
    security_group = azurerm_network_security_group.main.id
  }

  subnet {
    name           = "akssubnet"
    address_prefix = "10.2.1.0/24"
    security_group = azurerm_network_security_group.main.id
  }

  subnet {
    name           = "extrasubnet"
    address_prefix = "10.2.2.0/24"
    security_group = azurerm_network_security_group.main.id
    
  }

  
}
