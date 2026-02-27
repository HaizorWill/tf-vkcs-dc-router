data "vkcs_compute_availability_zones" "this" {}

data "vkcs_dc_api_options" "this" {}

variable "availability_zone" {
  type        = string
  description = "An availability zone in which resources are created"
  default     = null
  validation {
    condition     = contains(data.vkcs_compute_availability_zones.this.names, var.availability_zone) || var.availability_zone == null
    error_message = format("The availability zone provided does not exist! Available values are: %v", join(", ", data.vkcs_compute_availability_zones.this.names))
  }
}

variable "router_flavor" {
  type        = string
  description = "A flavor which is used for an advanced router"
  default     = "standard"
  validation {
    condition     = contains(data.vkcs_dc_api_options.this.flavors, var.router_flavor) || var.router_flavor == null
    error_message = format("The router flavor provided does not exist! Available value are: %v", join(", ", data.vkcs_dc_api_options.this.flavors))
  }
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
    network_id           = string
    subnet_id            = optional(string)
    ip_address           = optional(string)
    bgp_announce_enabled = optional(bool)
  }))
  description = "A list of interfaces which are connected to the advanced router"
  default     = null
}

variable "dnat_rules" {
  type = list(object({
    name            = optional(string)
    resource_key    = optional(string)
    description     = optional(string)
    dc_interface_id = string
    protocol        = string
    to_destination  = string
    source          = optional(string)
    destination     = optional(string)
    port            = optional(number)
    to_port         = optional(number)
  }))
  description = "A list of port forwarding rules which are added to the router's configuration"
  default     = null
}

variable "routes" {
  type = list(object({
    name         = optional(string)
    resource_key = optional(string)
    description  = optional(string)
    network      = string
    gateway      = string
    metric       = optional(number)
  }))
  description = "A list of static routes which are added to the router's routing table"
  default     = null
}

variable "bgp_instances" {
  type = list(object({
    name                        = optional(string)
    resource_key                = optional(string)
    description                 = optional(string)
    enabled                     = optional(bool)
    bgp_router_id               = string
    asn                         = number
    ecmp_enabled                = optional(bool)
    graceful_restart            = optional(bool)
    long_lived_graceful_restart = optional(bool)
  }))
  description = "A list of bgp instances which are added to the router's configuration"
  default     = null
}

variable "bgp_neighbors" {
  type = list(object({
    name         = optional(string)
    resource_key = optional(string)
    description  = optional(string)
    dc_bgp_id    = string
    remote_asn   = number
    remote_ip    = string
  }))
  description = "A list of BGP neighbors that are added to the BGP instance configuration"
  default     = null
}
