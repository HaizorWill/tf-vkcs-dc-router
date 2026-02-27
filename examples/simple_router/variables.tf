variable "router_name" {
  type        = string
  description = "The name of the router"
  default     = "dc_router"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone where the router will be created"
  default     = null
}
