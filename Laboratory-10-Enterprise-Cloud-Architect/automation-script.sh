#!/usr/bin/env bash
#
# CloudNova nightly backup: MariaDB dump + WordPress files, 7-day rotation.
# Scheduled by cron (see crontab). Logs to the journal with tag "cloudnova-backup".
#
set -euo pipefail
umask 077                       # backup files readable only by this user

BACKUP_DIR="$HOME/backups"
RETENTION_DAYS=7
DB_CONTAINER="cloudnova-db"
WEB_CONTAINER="cloudnova-web"
TS="$(date +%Y-%m-%d_%H%M%S)"
DB_FILE="$BACKUP_DIR/db_${TS}.sql.gz"
FILES_FILE="$BACKUP_DIR/wp_files_${TS}.tar.gz"

log() {
    echo "[$(date '+%F %T')] $*"
    logger -t cloudnova-backup "$*" || true
}

on_error() {
    rm -f "$DB_FILE" "$FILES_FILE"
    log "BACKUP FAILED - partial files removed"
}
trap on_error ERR

mkdir -p "$BACKUP_DIR"
log "Backup started"

# 1) Database dump (the password is read inside the container, never stored here)
docker exec "$DB_CONTAINER" sh -c 'exec mariadb-dump -u root -p"$MARIADB_ROOT_PASSWORD" --single-transaction --databases "$MARIADB_DATABASE"' | gzip > "$DB_FILE"
gzip -t "$DB_FILE"

# 2) WordPress files (themes, plugins, uploads, wp-config.php)
#    tar exits 1 if a file changed while reading; that is only a warning
docker exec "$WEB_CONTAINER" tar -czf - -C /var/www/html . > "$FILES_FILE" || [ $? -eq 1 ]
gzip -t "$FILES_FILE"

# 3) Rotation: remove backups older than RETENTION_DAYS
find "$BACKUP_DIR" -maxdepth 1 -type f \( -name 'db_*.sql.gz' -o -name 'wp_files_*.tar.gz' \) -mtime +"$RETENTION_DAYS" -delete

log "Backup finished: $(basename "$DB_FILE") ($(du -h "$DB_FILE" | cut -f1)), $(basename "$FILES_FILE") ($(du -h "$FILES_FILE" | cut -f1))"
