locals {
  interfaces = {
    for id, interface in var.interfaces :
    coalesce(interface.resource_key, interface.name, format("iface-%s", replace(coalesce(interface.ip_address, id), ".", "-"))) => interface
  }
  dnat_rules = {
    for id, rule in var.dnat_rules : coalesce(rule.resource_key, rule.name) => rule
  }
  routes        = { for id in var.routes : id.name => id }
  bgp_neighbors = { for id in var.bgp_neighbors : id.name => id }
}
