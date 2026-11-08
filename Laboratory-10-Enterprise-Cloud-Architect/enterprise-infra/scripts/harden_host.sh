#!/usr/bin/env bash
# Extra host hardening: automatic security updates, fail2ban, SSH hardening.
# Password SSH login is disabled ONLY if the invoking user already has an
# authorized SSH key, so you cannot lock yourself out.
# Usage: sudo ./scripts/harden_host.sh
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Run as root: sudo $0" >&2
  exit 1
fi

TARGET_USER="${SUDO_USER:-}"
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y unattended-upgrades fail2ban

# 1) Automatic security updates
cat > /etc/apt/apt.conf.d/20auto-upgrades <<'EOF'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
EOF

# 2) fail2ban: ban IPs after repeated failed SSH logins
cat > /etc/fail2ban/jail.d/sshd.local <<'EOF'
[sshd]
enabled = true
maxretry = 4
findtime = 10m
bantime = 1h
EOF
systemctl enable --now fail2ban
systemctl restart fail2ban

# 3) SSH hardening
SSH_CONF=/etc/ssh/sshd_config.d/99-hardening.conf
{
  echo "PermitRootLogin no"
  echo "MaxAuthTries 3"
  echo "X11Forwarding no"
  echo "LoginGraceTime 30"
} > "$SSH_CONF"

if [[ -n "$TARGET_USER" && -s "/home/$TARGET_USER/.ssh/authorized_keys" ]]; then
  echo "PasswordAuthentication no" >> "$SSH_CONF"
  echo "Key found for $TARGET_USER: password SSH login disabled."
else
  echo "No authorized key for '${TARGET_USER:-unknown}': password login left ON."
  echo "Run 'ssh-copy-id' from your laptop, then re-run this script."
fi

sshd -t                       # validate config before reloading
systemctl reload ssh

systemctl is-active fail2ban
fail2ban-client status sshd || true
echo "Host hardening complete."
