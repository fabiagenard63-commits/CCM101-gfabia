# Enterprise Infrastructure: Operational Manual

Handover documentation for the client IT team. This repository contains everything
needed to deploy, secure, back up, and maintain a two-tier WordPress + MariaDB
platform on Ubuntu Server, running as containers under Docker Compose.

| | |
|---|---|
| **Application** | WordPress (web tier) + MariaDB 11.4 (data tier) |
| **Platform** | Ubuntu Server VM on VirtualBox (Type 2 hypervisor) |
| **Provisioning** | Docker Compose (Infrastructure as Code) |
| **Security** | UFW host firewall, default deny, least-privilege ports |
| **Operations** | Nightly automated backup via cron, 7-day retention |

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the topology diagram and
[docs/REFLECTION.md](docs/REFLECTION.md) for the project reflection.

## Repository layout

```
.
├── docker-compose.yml        # Full stack definition (IaC)
├── .env.example              # Template for secrets (copy to .env)
├── scripts/
│   ├── install_docker.sh     # Installs Docker Engine + Compose
│   ├── harden_ufw.sh         # Firewall: default deny, allow 22 + 80
│   ├── backup_db.sh          # DB dump + files backup + retention
│   └── restore_db.sh         # Restore a DB dump
├── cron/backup.cron          # Daily 02:00 schedule
└── docs/
    ├── ARCHITECTURE.md       # Topology diagram
    └── REFLECTION.md         # Mission 1-10 reflection
```

---

## 1. Provision the virtual machine

### 1.1 VirtualBox VM settings (sized for an 8 GB laptop)

| Setting | Value |
|---|---|
| Name | `ent-ubuntu-server` |
| Type / Version | Linux / Ubuntu (64-bit) |
| Memory | **2560 MB** (leaves ~5.5 GB for the host OS) |
| CPUs | 2 |
| Disk | 25 GB, dynamically allocated VDI |
| Adapter 1 | **NAT** |
| Adapter 2 | **Host-only Adapter** (`vboxnet0`) |

Create the host-only network first: **File > Tools > Network Manager > Host-only
Networks > Create**. Use IPv4 `192.168.56.1`, mask `255.255.255.0`. DHCP server may stay on or off.

> Tip: close heavy host applications (browsers with many tabs) while the VM runs.

### 1.2 Install Ubuntu Server

1. Attach the Ubuntu Server ISO and boot the VM.
2. Choose **Ubuntu Server (minimized not required)**, accept defaults for storage.
3. Create an admin user (example: `admin`), set a strong password.
4. **Tick "Install OpenSSH server"**.
5. Skip optional snaps. Reboot and remove the ISO.

### 1.3 Static IP on the host-only adapter

Find interface names with `ip -br a` (typically `enp0s3` = NAT, `enp0s8` = host-only). Create
`/etc/netplan/60-hostonly.yaml`:

```yaml
network:
  version: 2
  ethernets:
    enp0s8:
      dhcp4: false
      addresses: [192.168.56.10/24]
```

Apply it:

```bash
sudo chmod 600 /etc/netplan/60-hostonly.yaml
sudo netplan apply
ip -br a      # confirm 192.168.56.10 on enp0s8
```

From the laptop: `ping 192.168.56.10` and `ssh admin@192.168.56.10`.

---

## 2. Deploy the application

```bash
# On the VM
sudo apt update && sudo apt install -y git
sudo git clone https://github.com/<YOUR_USER>/<YOUR_REPO>.git /opt/enterprise-infra
sudo chown -R "$USER":"$USER" /opt/enterprise-infra
cd /opt/enterprise-infra

sudo ./scripts/install_docker.sh
# Log out and back in so the docker group applies, then:

cp .env.example .env
nano .env                       # replace every CHANGE_ME (openssl rand -base64 24)
chmod 600 .env

docker compose up -d
docker compose ps               # both services should be "running"/"healthy"
```

Open **http://192.168.56.10** in the laptop browser and complete the WordPress
installer.

### Verify persistence (required test)

```bash
docker volume ls | grep ent_      # ent_db_data and ent_wp_data exist
sudo reboot
# after boot:
docker compose -f /opt/enterprise-infra/docker-compose.yml ps
```

The site and all posts must still be present. Docker starts the containers
automatically (`restart: unless-stopped`).

---

## 3. Security hardening

### 3.1 Firewall (UFW), default deny

```bash
cd /opt/enterprise-infra
sudo ./scripts/harden_ufw.sh
sudo ufw status verbose
```

Expected policy:

```
Default: deny (incoming), allow (outgoing)
22/tcp   LIMIT   192.168.56.0/24     # SSH, admin network only, rate limited
80/tcp   ALLOW   Anywhere            # WordPress
```

Why only these ports: 22 is required for remote administration, 80 is the application.
MariaDB (3306) is intentionally **not** opened or published.

> **Docker and UFW caveat.** Docker inserts its own iptables rules for *published*
> ports, which can bypass UFW. This design limits the exposure by publishing
> **only** port 80 and giving the database no published ports. Never add
> `ports: "3306:3306"` to the `db` service. Verify from the laptop with
> `nmap -Pn 192.168.56.10`: only 22 and 80 should appear.

### 3.2 Extra hardening script (fail2ban, SSH, auto-updates)

```bash
# From your laptop first, so key login works:
ssh-keygen -t ed25519            # skip if you already have a key
ssh-copy-id admin@192.168.56.10
# On the VM:
sudo ./scripts/harden_host.sh
```

This enables unattended security updates, bans IPs after repeated failed SSH
logins (fail2ban), disables root login, and disables password SSH only if your key is installed.

### 3.3 Manual equivalent (reference)

```bash
# Automatic security updates
sudo apt install -y unattended-upgrades && sudo dpkg-reconfigure -plow unattended-upgrades

# SSH: key-based auth only (after copying your key with ssh-copy-id)
sudo nano /etc/ssh/sshd_config.d/99-hardening.conf
#   PasswordAuthentication no
#   PermitRootLogin no
sudo systemctl restart ssh
```

Test the key login in a **second terminal** before closing your current session.

### 3.4 Secrets handling

`.env` holds credentials, is listed in `.gitignore`, and must never be committed.
Only `.env.example` (placeholders) lives in Git.

---

## 4. Automation: backups

`scripts/backup_db.sh` runs nightly and performs:

1. A consistent MariaDB dump (`--single-transaction`), gzip-verified.
2. A tarball of the WordPress files volume.
3. Deletion of backups older than 7 days.
4. Logging to `/var/backups/enterprise-infra/backup.log`.

### Install and schedule

```bash
sudo chmod +x /opt/enterprise-infra/scripts/*.sh        # make executable
sudo mkdir -p /var/backups/enterprise-infra
sudo chown "$USER":"$USER" /var/backups/enterprise-infra

/opt/enterprise-infra/scripts/backup_db.sh              # manual test run
crontab /opt/enterprise-infra/cron/backup.cron          # schedule 02:00 daily
crontab -l                                              # verify
```

Cron expression `0 2 * * *` means minute 0, hour 2, every day.

### Restore procedure (disaster recovery)

```bash
ls -lh /var/backups/enterprise-infra/
/opt/enterprise-infra/scripts/restore_db.sh /var/backups/enterprise-infra/db_<STAMP>.sql.gz
```

To restore the files volume:

```bash
docker compose -f /opt/enterprise-infra/docker-compose.yml stop wordpress
docker run --rm -v ent_wp_data:/data -v /var/backups/enterprise-infra:/backup alpine:3 \
  sh -c "rm -rf /data/* && tar xzf /backup/wp_<STAMP>.tar.gz -C /data"
docker compose -f /opt/enterprise-infra/docker-compose.yml start wordpress
```

Backups on the same disk do not protect against disk loss. For production, copy
`/var/backups/enterprise-infra` to a separate location (second disk, NAS, or object storage).
Test a restore regularly.

---

## 5. Maintenance runbook

| Task | Command |
|---|---|
| Status | `docker compose ps` |
| Logs (follow) | `docker compose logs -f --tail=100` |
| Restart stack | `docker compose restart` |
| Update images | `docker compose pull && docker compose up -d` |
| Clean old images | `docker image prune -f` |
| Disk usage | `df -h && docker system df` |
| Firewall status | `sudo ufw status verbose` |
| Last backup | `tail -n 20 /var/backups/enterprise-infra/backup.log` |
| OS updates | `sudo apt update && sudo apt upgrade -y` |

Take a backup before every update.

## 6. Troubleshooting

| Symptom | Check |
|---|---|
| Browser cannot reach site | `ping 192.168.56.10`; `ip -br a` on the VM; `sudo ufw status`; `docker compose ps` |
| SSH refused/timeout | Host-only adapter enabled? `sudo ufw status` shows 22 from `192.168.56.0/24`? |
| WordPress "Error establishing a database connection" | `docker compose logs db`; verify `.env` values match; wait for the healthcheck |
| Backup did not run | `crontab -l`; `tail /var/backups/enterprise-infra/cron.log`; user in `docker` group? |
| VM slow | Lower VM load; confirm 2.5 GB RAM assigned and host is not swapping |
| Host-only interface name differs | Use the real name from `ip -br a` in the netplan file |

## 7. Command quick reference (full deploy order)

```bash
sudo ./scripts/install_docker.sh
cp .env.example .env && nano .env
docker compose up -d
sudo ./scripts/harden_ufw.sh
sudo ./scripts/harden_host.sh
chmod +x scripts/*.sh && crontab cron/backup.cron
```
