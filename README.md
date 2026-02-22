# VKCS Advanced Sprut router Terraform module

> **This module is heavily WIP**
> *It is not recommended for production use*

Terraform module that creates advanced Sprut router in VK Cloud.

As of now, it supports creating:
 * A **singular** dc_router
 * Multiple interfaces, including SNAT interface connected to external network
 * DNAT rules
 * Static routes
 * BGP instances
 * BGP neighbors

What it is not:
 * It is not a module for creating networks, subnets, you must create them before using this module
 * It is not a module for creating multiple advanced routers, and putting them in a VRRP domain
 * It is not a declarative opinionated module, it is a composable module -> you define objects you want to create, and is meant to be flexible
