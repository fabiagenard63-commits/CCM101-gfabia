# Operational Manual – CloudNova WordPress Stack

Handover manual for the client's IT team. It explains how the system is built, how to deploy it from scratch, how it is secured, how backups and restores work, and how to keep it healthy.

## 1. Purpose and Architecture

The system is a multi-tier web application: a **WordPress** web tier and a **MariaDB** data tier, both running as Docker containers on an **Ubuntu Server** virtual machine. A host-based firewall protects the server, and a scheduled script backs up the data every night.

| Component | Detail |
|---|---|
| Host | Windows laptop, accesses the site at `http://localhost:8080` and the server over SSH on port `2222` |
| Hypervisor | VirtualBox (Type 2), NAT networking, port forwarding `8080 → 80` and `2222 → 22` |
| Guest OS | Ubuntu Server 26.04.1 LTS, time zone `Asia/Manila` |
| Containers | `cloudnova-web` (WordPress), `cloudnova-db` (MariaDB 11.4) |
| Networks | `frontend` (web only), `backend` (web + database) |
| Volumes | `wp_data` (site files), `db_data` (database) |
| Project folder | `~/cloudnova-stack` on the VM |

See `architecture-diagram.png` for the picture.

## 2. Deploy from Scratch

**2.1 Install Docker Engine and the Compose plugin** (Ubuntu):

```bash
sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
```

Log out and back in so the group change applies, then check `docker --version`, `docker compose version`, and `systemctl is-enabled docker` (must say `enabled`).

**2.2 Prepare the project folder:**

```bash
mkdir -p ~/cloudnova-stack/scripts ~/backups
cd ~/cloudnova-stack
```

Copy `docker-compose.yml` into this folder and the backup script to `scripts/backup.sh` (the repository file is named `automation-script.sh`).

**2.3 Create the secrets file.** Passwords are generated randomly and never stored in the repository:

```bash
cat > .env <<EOF
DB_NAME=wordpress
DB_USER=wpuser
DB_PASSWORD=$(openssl rand -hex 16)
DB_ROOT_PASSWORD=$(openssl rand -hex 16)
EOF
chmod 600 .env
```

**2.4 Validate and start the stack:**

```bash
docker compose config --quiet && echo "compose file OK"
docker compose up -d
docker compose ps
```

Wait until `cloudnova-db` shows `healthy`. Then open `http://localhost:8080` and complete the WordPress installer (site title, admin user that is not `admin`, strong password).

**Why the compose file is built this way**
- The database has no `ports:` entry, so only the web container can reach it.
- Named volumes keep the data outside the containers.
- `restart: unless-stopped` brings both containers back after a reboot.
- The healthcheck and `depends_on` make WordPress wait until MariaDB is ready.
- Log limits (3 files × 10 MB per container) stop Docker logs from filling the disk.

## 3. Secure

Host firewall (UFW), configured with SSH allowed **before** enabling it:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw limit 22/tcp comment 'SSH (rate limited)'
sudo ufw allow 80/tcp comment 'WordPress web'
sudo ufw enable
sudo ufw status verbose
```

| Control | Setting |
|---|---|
| Incoming traffic | Denied by default |
| Allowed | `22/tcp` (rate limited) and `80/tcp` only |
| Database exposure | No published port; reachable only on the `backend` network |
| Secrets | In `.env` (mode 600), excluded from git by `.gitignore` |
| Backups | Created with `umask 077`, readable only by the owner |

Verify what is listening with `sudo ss -tlnp`: only `sshd` (22) and Docker's proxy (80) should appear, and nothing on 3306.

**Important:** Docker publishes container ports with its own firewall rules, which bypass UFW's incoming rules. This is why the stack publishes only port 80, and the database publishes nothing. Never add a `ports:` entry to the database service.

## 4. Backup and Restore

**What is backed up:** the WordPress database (`mariadb-dump`) and the site files (`/var/www/html`), into `~/backups`. Files older than 7 days are deleted automatically.

**Schedule** (cron, every day at 2:00 AM server time):

```
0 2 * * * /home/<user>/cloudnova-stack/scripts/backup.sh >> /home/<user>/backups/cron.log 2>&1
```

**Check that it ran:**

```bash
ls -lh ~/backups
sudo journalctl -u cron --since "1 day ago" --no-pager | tail
sudo journalctl -t cloudnova-backup --since "1 day ago" --no-pager | tail
```

**Restore the database** from the newest dump:

```bash
LATEST=$(ls -t ~/backups/db_*.sql.gz | head -1)
echo "Restoring from $LATEST"
gunzip -c "$LATEST" | docker exec -i cloudnova-db sh -c 'exec mariadb -u root -p"$MARIADB_ROOT_PASSWORD"'
```

**Restore the site files** (only if they were lost):

```bash
LATEST_FILES=$(ls -t ~/backups/wp_files_*.tar.gz | head -1)
docker exec -i cloudnova-web tar -xzf - -C /var/www/html < "$LATEST_FILES"
```

**Restore drill performed:** I took a backup, deleted the database on purpose (`DROP DATABASE wordpress;`), confirmed the site showed "Error establishing a database connection", restored from the dump, and confirmed the published page came back. Screenshots 11, 11b, and 11c.

## 5. Routine Maintenance

| Task | Command |
|---|---|
| Status of containers | `cd ~/cloudnova-stack && docker compose ps` |
| Read logs | `docker compose logs --tail 50` |
| Update the images | `docker compose pull && docker compose up -d` |
| Disk usage | `df -h` and `docker system df` |
| Firewall status | `sudo ufw status verbose` |
| Backup history | `ls -lh ~/backups` |
| OS updates | `sudo apt update && sudo apt upgrade -y` |

**Warning:** never run `docker compose down -v`. The `-v` flag deletes the volumes, and the data with them. Plain `docker compose down` is safe.

## 6. Troubleshooting (problems encountered during this build)

| Symptom | Cause | Fix |
|---|---|---|
| The VirtualBox Port Forwarding button was missing | The Settings window was in Basic mode, which hides the Advanced section | Switch to the **Expert** tab, then Network → Adapter 1 → Port Forwarding |
| VirtualBox asked for a user name and password instead of showing the installer | "Proceed with Unattended Installation" was ticked | Go back and untick it so the normal Ubuntu installer runs |
| `docker : The term 'docker' is not recognized` | The command was run in a Windows PowerShell prompt (`PS C:\...`) instead of inside the VM | Connect with `ssh -p 2222 <user>@127.0.0.1` first; the prompt must show the server name |
| `git : The term 'git' is not recognized` | Git was not installed on Windows | `winget install --id Git.Git -e --source winget`, then refresh the PATH or reopen PowerShell |
| `command not found` for `hostnamectl` | Typed the number `1` instead of the letter `l` | The command ends in a lowercase L: `hostnamectl` |
| A repository was cloned inside `~/cloudnova-stack` | `git clone` was run at the VM prompt by mistake | `cd ~/cloudnova-stack && rm -rf <repo-folder>` (it only held a copy of GitHub) |

Other problems and fixes:

| Symptom | Fix |
|---|---|
| Site shows "Error establishing a database connection" right after start | The database is still starting; wait for `healthy` in `docker compose ps` |
| Changed a password in `.env` and WordPress cannot connect | MariaDB reads the passwords only when its volume is first created; restore the original `.env` value |
| Locked out after `ufw enable` | Log in on the VM console and run `sudo ufw allow 22/tcp` |
| Cron job did not run | Check `systemctl is-active cron`, use absolute paths, make sure `~/backups` exists and the script is executable |

## 7. Known Limitations

- Backups live on the same VM. If the VM is lost, the backups go with it. They should be copied to another machine or cloud storage.
- The site is served over HTTP only. A production deployment needs HTTPS (reverse proxy and certificate).
- Database credentials are stored in a local `.env` file. A secrets manager would be better in production.
- There is no monitoring or alerting; a failed backup is only visible in the journal.
