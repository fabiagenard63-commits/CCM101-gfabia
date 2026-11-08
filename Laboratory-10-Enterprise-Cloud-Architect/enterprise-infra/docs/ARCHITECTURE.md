# Architecture & Network Topology

## Network topology diagram

![Network topology](docs/topology.png)

Editable source: [`docs/topology.drawio`](docs/topology.drawio) (open it at https://app.diagrams.net).

Nesting, outer to inner: **Laptop > VirtualBox > Ubuntu VM > UFW > Docker > containers**.

## Network design

| Adapter | VirtualBox mode | Guest IP | Purpose |
|---|---|---|---|
| Adapter 1 | NAT | 10.0.2.15 (DHCP) | Outbound internet: apt, Docker image pulls |
| Adapter 2 | Host-only (`vboxnet0`) | 192.168.56.10 (static) | Reach the server from the laptop browser and SSH |

The host-only network is isolated: nothing outside the laptop can reach the VM.

## Trust boundaries

1. **Laptop to VM**: only via the host-only network; UFW permits only SSH (admin subnet) and HTTP.
2. **VM to containers**: only port 80 is published by Docker.
3. **Web tier to data tier**: the database lives on an `internal` Docker network and publishes no ports.
