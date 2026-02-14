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
    resource_key         = optional(string)
    description          = optional(string)
    network_id           = optional(string)
    subnet_id            = optional(string)
    ip_address           = optional(string)
    bgp_announce_enabled = optional(bool)
  }))
  description = "A list of interfaces which are connected to the advanced router"
  default = [{
    bgp_announce_enabled = false
  }] # Move it to locals later?
}

variable "static_routes" {
  type        = bool
  description = "Controls whether static routes are created or not"
  default     = false
}

variable "routes" {
  type = list(object({
    name         = optional(string)
    resource_key = optional(string)
    description  = optional(string)
    network      = optional(string)
    gateway      = optional(string)
    metric       = optional(number)
  }))
  description = "A list of static routes which are added to the router's routing table"
  default     = [{}]
}

variable "bgp_enabled" {
  type        = bool
  description = "Controls whether BGP instances are created or not"
  default     = false
}

variable "bgp_instances" {
  type = list(object({
    name                        = optional(string)
    description                 = optional(string)
    enabled                     = optional(bool)
    bgp_router_id               = optional(string)
    asn                         = optional(number)
    ecmp_enabled                = optional(bool)
    graceful_restart            = optional(bool)
    long_lived_graceful_restart = optional(bool)
  }))
  description = "A list of bgp instances that are added to the router's configuration"
  default     = [{}]
}

# variable "bgp_neighbors" {
#   type = list(object({
#
#   }))
# }
