variable "region" {
  type        = string
  description = "An openstack region in which resources are created"
  default     = null
}

variable "availability_zone" {
  type        = string
  description = "An availability zone in which resources are created"
  default     = null
}

variable "name" {
  type        = string
  description = "A name which is given to the advanced router created"
  default     = null
}

variable "interfaces" {
  type = list(object({
    name                 = optional(string)
    description          = optional(string)
    network_id           = string
    subnet_id            = optional(string)
    ip_address           = optional(string)
    bgp_announce_enabled = optional(bool)
  }))
  description = "A list of interfaces which are connected to the advanced router"
  default = [{
    network_id           = null
    bgp_announce_enabled = false
  }]
}

variable "routes" {
  type = list(object({
    name        = optional(string)
    description = optional(string)
    network     = optional(string)
    gateway     = optional(string)
    metric      = optional(number)
  }))
  description = "A list of static routes which are added to the router's routing table"
}
