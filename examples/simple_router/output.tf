output "router_id" {
  value       = module.dc-router.router.id
  description = "The ID of the router"
}

output "router_name" {
  value       = module.dc-router.router.name
  description = "The name of the router"
}

output "router_availability_zone" {
  value       = module.dc-router.router.availability_zone
  description = "The availability zone where the router is being created"
}

output "interface_extnet" {
  value       = module.dc-router.interfaces.iface-extnet
  description = "Map of parameters of the interface connected to the external network"
}

output "interface_subnet_1" {
  value       = module.dc-router.interfaces.iface-subnet-1
  description = "Map of parameters of the interface connected to the internal network"
}
