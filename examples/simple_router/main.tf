data "vkcs_networking_network" "extnet" {
  sdn      = "sprut"
  external = true
}

resource "vkcs_networking_network" "local-network" {
  name = "local-network"
}

resource "vkcs_networking_subnet" "subnet-1" {
  name        = "subnet-1"
  network_id  = vkcs_networking_network.local-network.id
  cidr        = "10.0.0.0/24"
  gateway_ip  = "10.0.0.254"
  enable_dhcp = true

  depends_on = [vkcs_networking_network.local-network]
}

module "dc-router-1" {
  source            = "github.com/HaizorWill/terraform-vkcs-dc-router"
  name              = "dc-router-1"
  availability_zone = "PA2"
  interfaces = [{
    name                 = "WAN"
    network_id           = data.vkcs_networking_network.extnet.id
    bgp_announce_enabled = false
    }, {
    name                 = "LAN"
    network_id           = vkcs_networking_network.local-network.id
    subnet_id            = vkcs_networking_subnet.subnet-1.id
    ip_address           = vkcs_networking_subnet.subnet-1.gateway_ip
    bgp_announce_enabled = true
  }]
  dnat_rules = [{
    name            = "rule"
    protocol        = "tcp"
    dc_interface_id = module.dc-router-1.interfaces.LAN.id
    to_destination  = "10.0.0.1"
    port            = 2222
    to_port         = 22
  }]
  bgp_instances = [{
    name          = "bgp-instance"
    bgp_router_id = module.dc-router-1.interfaces.LAN.ip_address
    enabled       = true
    asn           = 65000
    ecmp_enabled  = false
  }]
  bgp_neighbors = [{
    name       = "neighbor"
    dc_bgp_id  = module.dc-router-1.bgp_instances.bgp-instance.id
    remote_asn = 65001
    remote_ip  = "10.0.0.1"
  }]
  routes = []

  depends_on = [vkcs_networking_subnet.subnet-1, data.vkcs_networking_network.extnet]
}
