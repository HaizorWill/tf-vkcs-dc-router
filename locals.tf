locals {
  interfaces = {
    for id, interface in var.interfaces :
    coalesce(interface.resource_key, interface.name, format("iface-%s", replace(coalesce(interface.ip_address, id), ".", "-"))) => merge(interface, {
      bgp_announce_enabled = interface.bgp_announce_enabled != null ? interface.bgp_announce_enabled : false
    })
    # I am not sure if naming "iface-10-10-10-1" is great, might get rid of it, ID is fine
  }
  dnat_rules = {
    for id, rule in var.dnat_rules :
    coalesce(rule.resource_key, format("dnat-rule-%s", id)) => merge(rule, {
      to_port = rule.port != null && rule.to_port == null ? rule.port : rule.to_port
    })
  }
  routes = { for id, route in var.routes :
    coalesce(route.resource_key, route.name, format("route-%s", id)) => route
  }
  bgp_instances = { for id, instance in var.bgp_instances :
    coalesce(instance.resource_key, instance.name, format("instance-%s", id)) => instance
  }
  bgp_neighbors = { for id, neighbor in var.bgp_neighbors :
    coalesce(neighbor.resource_key, neighbor.name, format("bgp-neighbor-%s", id)) => neighbor
  }
}

