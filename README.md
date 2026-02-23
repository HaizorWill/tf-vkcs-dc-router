# VKCS Advanced Sprut Router Terraform Module

> **This module is under development, and is not recommended for production use**

Terraform module that creates an advanced Sprut router in VK Cloud.

It aims to provide a flexible and simplified way to create advanced routers in VK Public Cloud.

> It may also work with VK Private Cloud, as it is not tightly coupled to Public Cloud only. However, it has not been tested with Private Cloud and it is not planned to be in a foreseable future.

## Features

Currently, it supports creating:

 * A single dc_router
 * Multiple interfaces, including SNAT interface connected to external network
 * DNAT rules
 * Static routes
 * BGP instances
 * BGP neighbors

## What this module is not

 * It does not create networks or subnets; they must be created beforehand and passed to the module
 * It does not manage multiple advanced routers or VRRP domains
 * It is not an opinionated declarative module. Instead, it is composable - you explicitly define objects to be created, allowing for maximum flexibility

## Inputs

### <a name="availability_zone"></a> [availability_zone](#availability\_zone)

Description: an availability zone in which resources are created.

Type: `string`

Default: `null`

### <a name="router_flavor"></a> [router_flavor](#router\_flavor)

Description: a flavor which is used for an advanced router

Type: `string`

Default: `standard`

### <a name="name"></a> [name](#name)

Description: a name which is given to the advanced router created

Type: `string`

Default: `null`

### <a name="interfaces"></a> [interfaces](#interfaces)

Description: a list of interfaces which are connected to the advanced router

Type:
```hcl
list(object({
    name                 = optional(string)
    resource_key         = optional(string)
    description          = optional(string)
    network_id           = string
    subnet_id            = optional(string)
    ip_address           = optional(string)
    bgp_announce_enabled = optional(bool)
}))
```

### <a name="dnat_rules"></a> [dnat_rules](#dnat\_rules)

Description: a list of port forwarding rules which are added to the router's configuration

Type:
```hcl
list(object({
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
```

### <a name="routes"></a> [routes](#routes)

Description: a list of static routes which are added to the router's routing table

Type:
```hcl
list(object({
    name         = optional(string)
    resource_key = optional(string)
    description  = optional(string)
    network      = string
    gateway      = string
    metric       = optional(number)
}))
```

### <a name="bgp_instances"></a> [bgp_instances](#bgp\_instances)

Description: a list of bgp instances which are added to the router's configuration

Type:
```hcl
list(object({
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
```

### <a name="bgp_neighbors"></a> [bgp_neighbors](#bgp\_neighbors)

Description: a list of BGP neighbors that are added to the BGP instance configuration

Type:
```hcl
list(object({
    name         = optional(string)
    resource_key = optional(string)
    description  = optional(string)
    dc_bgp_id    = string
    remote_asn   = number
    remote_ip    = string
}))
```

## Contribution

Feel free to contribute if you want to, i'd love to see it!
