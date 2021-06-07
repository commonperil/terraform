name="gcto-blueprints-sandpit-vwan"
resource_group={
    name = "gcto-blueprints-network-eus2",
    location = "eastus2"
 }

 wan-prefix = "10.1.0.0/23"

hubs =  [{
  region  = "eastus2",
  prefix = "10.1.0.0/23"
 }
]