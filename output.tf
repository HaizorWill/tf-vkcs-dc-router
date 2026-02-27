output "router" {
  value = {
    id                = vkcs_dc_router.this.id
    name              = vkcs_dc_router.this.name
    availability_zone = vkcs_dc_router.this.availability_zone
    created_at        = vkcs_dc_router.this.created_at
    updated_at        = vkcs_dc_router.this.updated_at
  }
}

output "interfaces" {
  value = { for key, interface in vkcs_dc_interface.this : key => {
    id          = vkcs_dc_interface.this[key].id
    ip_netmask  = vkcs_dc_interface.this[key].ip_netmask
    network_id  = vkcs_dc_interface.this[key].network_id
    ip_address  = vkcs_dc_interface.this[key].ip_address
    mac_address = vkcs_dc_interface.this[key].mac_address
    mtu         = vkcs_dc_interface.this[key].mtu
    port_id     = vkcs_dc_interface.this[key].port_id
    sdn         = vkcs_dc_interface.this[key].sdn
    created_at  = vkcs_dc_interface.this[key].created_at
    updated_at  = vkcs_dc_interface.this[key].updated_at
    }
  }
}

output "dnat_rules" {
  value = { for key, rule in vkcs_dc_ip_port_forwarding.this : key => {
    id              = vkcs_dc_ip_port_forwarding.this[key].id
    name            = vkcs_dc_ip_port_forwarding.this[key].name
    dc_interface_id = vkcs_dc_ip_port_forwarding.this[key].dc_interface_id
    protocol        = vkcs_dc_ip_port_forwarding.this[key].protocol
    to_destination  = vkcs_dc_ip_port_forwarding.this[key].to_destination
    source          = vkcs_dc_ip_port_forwarding.this[key].source
    destination     = vkcs_dc_ip_port_forwarding.this[key].destination
    port            = vkcs_dc_ip_port_forwarding.this[key].port
    to_port         = vkcs_dc_ip_port_forwarding.this[key].to_port
    created_at      = vkcs_dc_ip_port_forwarding.this[key].created_at
    updated_at      = vkcs_dc_ip_port_forwarding.this[key].updated_at
    }
  }
}

output "static_routes" {
  value = { for key, route in vkcs_dc_static_route.this : key => {
    id         = vkcs_dc_static_route.this[key].id
    network    = vkcs_dc_static_route.this[key].network
    gateway    = vkcs_dc_static_route.this[key].gateway
    metric     = vkcs_dc_static_route.this[key].metric
    created_at = vkcs_dc_static_route.this[key].created_at
    updated_at = vkcs_dc_static_route.this[key].updated_at
  } }
}

output "bgp_instances" {
  value = { for key, instance in vkcs_dc_bgp_instance.this : key => {
    id            = vkcs_dc_bgp_instance.this[key].id
    enabled       = vkcs_dc_bgp_instance.this[key].enabled
    bgp_router_id = vkcs_dc_bgp_instance.this[key].bgp_router_id
    created_at    = vkcs_dc_bgp_instance.this[key].created_at
    updated_at    = vkcs_dc_bgp_instance.this[key].updated_at
  } }
}
