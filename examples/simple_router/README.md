# Simple advanced Sprut router with BGP peering

This example configures a simple Direct Connect router connected to provider(external) network.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| router_name | The name of the router | `string` | "dc_router" | no |
| availability_zone | The availability zone where the router will be created | `string` | null | no |

## Outputs

| Name | Description |
|------|-------------|
| router_id | The ID of the router |
| router_name | The name of the router |
| router_availability_zone | The availability zone where the router is being created |
| interface_extnet | Map of parameters of the interface connected to the external network |
| interface_subnet_1 | Map of parameters of the interface connected to the internal network |
