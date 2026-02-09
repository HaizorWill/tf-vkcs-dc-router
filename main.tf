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

  depends_on = [vkcs_dc_router.this]
}

resource "vkcs_dc_static_route" "this" {
  for_each = { for r in var.routes : r.name => r }

  name         = each.value.name
  description  = each.value.description
  region       = var.region
  dc_router_id = vkcs_dc_router.this.id
  network      = each.value.name
  gateway      = each.value.gateway
  metric       = each.value.metric
}
