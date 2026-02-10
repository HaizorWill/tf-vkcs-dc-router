output "router" {
  value = {
    id         = vkcs_dc_router.this.id
    created_at = vkcs_dc_router.this.created_at
    updated_at = vkcs_dc_router.this.updated_at
  }
}

output "interfaces" {
  value = { for key, interface in vkcs_dc_interface.this : key => {
    id          = vkcs_dc_interface.this[key].id
    ip_netmask  = vkcs_dc_interface.this[key].ip_netmask
    mac_address = vkcs_dc_interface.this[key].mac_address
    mtu         = vkcs_dc_interface.this[key].mtu
    port_id     = vkcs_dc_interface.this[key].port_id
    sdn         = vkcs_dc_interface.this[key].sdn
    created_at  = vkcs_dc_interface.this[key].created_at
    updated_at  = vkcs_dc_interface.this[key].updated_at
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

