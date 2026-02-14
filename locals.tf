locals {
  interfaces = [
    for id, interface in var.interfaces : merge(interface, {
      interface_id = id
      resource_key = coalesce(interface.resource_key, interface.name, format("iface-%s", coalesce(interface.ip_address, id)))
      }
    )
  ]
  routes = [
    for id, route in var.routes : merge(route, {
      route_id     = id
      resource_key = coalesce(route.resource_key, route.name, format("route-%s", coalesce(route.gateway, id)))
      }
    )
  ]
}
