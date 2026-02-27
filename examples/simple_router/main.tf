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
  gateway_ip  = "10.0.0.1"
  enable_dhcp = true

  depends_on = [vkcs_networking_network.local-network]
}

module "dc-router" {
  source            = "github.com/HaizorWill/terraform-vkcs-dc-router"
  name              = var.router_name
  availability_zone = var.availability_zone
  interfaces = [{
    name                 = "WAN"
    resource_key         = "iface-extnet"
    network_id           = data.vkcs_networking_network.extnet.id
    bgp_announce_enabled = false
    }, {
    name                 = "LAN"
    resource_key         = "iface-subnet-1"
    network_id           = vkcs_networking_network.local-network.id
    subnet_id            = vkcs_networking_subnet.subnet-1.id
    ip_address           = vkcs_networking_subnet.subnet-1.gateway_ip
    bgp_announce_enabled = true
  }]

  depends_on = [vkcs_networking_subnet.subnet-1, data.vkcs_networking_network.extnet]
}
