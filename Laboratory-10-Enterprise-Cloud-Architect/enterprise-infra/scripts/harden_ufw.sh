#!/usr/bin/env bash
# Host firewall (UFW): default deny inbound, allow only SSH + HTTP.
# SSH is restricted to the VirtualBox host-only network so only the admin
# laptop can administer the server.
# Usage: sudo ./scripts/harden_ufw.sh
set -euo pipefail

ADMIN_NET="${ADMIN_NET:-192.168.56.0/24}"   # VirtualBox host-only subnet

if [[ $EUID -ne 0 ]]; then
  echo "Run as root: sudo $0" >&2
  exit 1
fi

apt-get install -y ufw

ufw --force reset
ufw default deny incoming
ufw default allow outgoing

# Allow SSH BEFORE enabling, or you will lock yourself out.
# 'limit' = allow, but rate-limit repeated connection attempts (brute force).
ufw limit from "$ADMIN_NET" to any port 22 proto tcp comment 'SSH from admin network'

# Web application
ufw allow 80/tcp comment 'WordPress HTTP'

ufw logging low
ufw --force enable

ufw status verbose
