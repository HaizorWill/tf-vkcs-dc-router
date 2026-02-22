resource "vkcs_dc_router" "this" {
  name              = var.name
  availability_zone = var.availability_zone
  flavor            = "standard" # This is hard coded, since there are no other options at the moment
}

resource "vkcs_dc_interface" "this" {
  for_each = local.interfaces

  name                 = each.value.name
  description          = each.value.description
  dc_router_id         = vkcs_dc_router.this.id
  network_id           = each.value.network_id
  subnet_id            = each.value.subnet_id
  ip_address           = each.value.ip_address
  bgp_announce_enabled = each.value.bgp_announce_enabled

  depends_on = [vkcs_dc_router.this]
}

resource "vkcs_dc_ip_port_forwarding" "this" {
  for_each = local.dnat_rules

  name            = each.value.name
  description     = each.value.description
  dc_interface_id = each.value.dc_interface_id
  protocol        = each.value.protocol
  to_destination  = each.value.to_destination
  source          = each.value.source
  destination     = each.value.destination
  port            = each.value.port
  to_port         = each.value.to_port

  depends_on = [vkcs_dc_interface.this]
}

resource "vkcs_dc_static_route" "this" {
  for_each = { for r in local.routes : r.name => r if var.static_routes }

  name         = each.value.name
  description  = each.value.description
  dc_router_id = vkcs_dc_router.this.id
  network      = each.value.network
  gateway      = each.value.gateway
  metric       = each.value.metric

  depends_on = [vkcs_dc_router.this]
}

resource "vkcs_dc_bgp_instance" "this" {
  for_each = { for i in var.bgp_instances : i.name => i if var.bgp_enabled }

  name                        = each.value.name
  description                 = each.value.description
  dc_router_id                = vkcs_dc_router.this.id
  enabled                     = each.value.enabled
  bgp_router_id               = each.value.bgp_router_id
  asn                         = each.value.asn
  ecmp_enabled                = each.value.ecmp_enabled
  graceful_restart            = each.value.graceful_restart
  long_lived_graceful_restart = each.value.long_lived_graceful_restart

  depends_on = [vkcs_dc_router.this]
}

resource "vkcs_dc_bgp_neighbor" "this" {
  for_each = local.bgp_neighbors

  name        = each.value.name
  description = each.value.description
  dc_bgp_id   = each.value.dc_bgp_id
  remote_asn  = each.value.remote_asn
  remote_ip   = each.value.remote_ip

  depends_on = [vkcs_dc_bgp_instance.this]
}
