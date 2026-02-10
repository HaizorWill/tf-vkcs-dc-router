resource "vkcs_dc_router" "this" {
  name              = var.name
  region            = var.region
  availability_zone = var.availability_zone
  flavor            = "standard" # This is hard coded, since there are no other options at the moment
}

resource "vkcs_dc_interface" "this" {
  for_each = { for i in var.interfaces : i.name => i }

  name                 = each.value.name
  description          = each.value.description
  region               = var.region
  dc_router_id         = vkcs_dc_router.this.id
  network_id           = each.value.network_id
  subnet_id            = each.value.subnet_id
  ip_address           = each.value.ip_address
  bgp_announce_enabled = each.value.bgp_announce_enabled
}

resource "vkcs_dc_static_route" "this" {
  for_each = { for r in var.routes : r.name => r if var.static_routes }

  name         = each.value.name
  description  = each.value.description
  region       = var.region
  dc_router_id = vkcs_dc_router.this.id
  network      = each.value.network
  gateway      = each.value.gateway
  metric       = each.value.metric
}

resource "vkcs_dc_bgp_instance" "this" {
  for_each = { for i in var.bgp_instances : i.name => i if var.bgp_enabled }

  name                        = each.value.name
  description                 = each.value.description
  region                      = var.region
  dc_router_id                = vkcs_dc_router.this.id
  enabled                     = each.value.enabled
  bgp_router_id               = each.value.bgp_router_id
  asn                         = each.value.asn
  ecmp_enabled                = each.value.ecmp_enabled
  graceful_restart            = each.value.graceful_restart
  long_lived_graceful_restart = each.value.long_lived_graceful_restart
}

# resource "vkcs_dc_bgp_neighbor" "this" {
#   for_each = { for n in var.bgp_neighbors : n.name => n if var.bgp_enabled }
#
#   name        = each.value.name
#   description = each.value.description
#   region      = var.region
# }
