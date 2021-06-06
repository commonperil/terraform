name="gcto-blueprints-sandpit-vwan"
resource_group={
    name = "gcto-blueprints-network-eus2-vnet",
    location = "eastus2"
 }

hubs =  [{
  region  = "eastus2",
  prefix = "10.1.1.0/23"
 }
]