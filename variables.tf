data "vkcs_compute_availability_zones" "this" {}

variable "availability_zone" {
  type        = string
  description = "An availability zone in which resources are created"
  default     = null
  validation {
    condition     = contains(data.vkcs_compute_availability_zones.this.names, var.availability_zone) || var.availability_zone == null
    error_message = format("The availability zone provided does not exist! Available values are: %v", join(",", data.vkcs_compute_availability_zones.this.names))
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
    network      = string
    gateway      = string
    metric       = optional(number)
  }))
  description = "A list of static routes which are added to the router's routing table"
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
    bgp_router_id               = string
    asn                         = number
    ecmp_enabled                = optional(bool)
    graceful_restart            = optional(bool)
    long_lived_graceful_restart = optional(bool)
  }))
  description = "A list of bgp instances that are added to the router's configuration"
}

variable "bgp_neighbors" {
  type = list(object({
    name        = optional(string)
    description = optional(string)
    dc_bgp_id   = optional(string)
    remote_asn  = optional(number)
    remote_ip   = optional(string)
  }))
  description = "A list of BGP neighbors that are added to the BGP instance configuration"
}
