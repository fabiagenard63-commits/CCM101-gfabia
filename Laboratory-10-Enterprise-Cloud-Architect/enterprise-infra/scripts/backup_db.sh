#!/usr/bin/env bash
# Nightly backup: MariaDB dump + WordPress files volume, with retention.
# Credentials are read from inside the db container's own environment,
# so no password is stored in this script or in cron.
#
# Usage:  ./scripts/backup_db.sh
# Env:    BACKUP_DIR (default /var/backups/enterprise-infra)
#         RETENTION_DAYS (default 7)
set -euo pipefail

BACKUP_DIR="${BACKUP_DIR:-/var/backups/enterprise-infra}"
RETENTION_DAYS="${RETENTION_DAYS:-7}"
DB_CONTAINER="${DB_CONTAINER:-ent_db}"
WP_VOLUME="${WP_VOLUME:-ent_wp_data}"
STAMP="$(date +%Y%m%d_%H%M%S)"
LOG="$BACKUP_DIR/backup.log"

mkdir -p "$BACKUP_DIR"
chmod 700 "$BACKUP_DIR"

log() { echo "$(date '+%F %T') $*" | tee -a "$LOG"; }

trap 'log "ERROR: backup failed (line $LINENO)"' ERR

if ! docker inspect -f '{{.State.Running}}' "$DB_CONTAINER" 2>/dev/null | grep -q true; then
  log "ERROR: container $DB_CONTAINER is not running"
  exit 1
fi

log "START backup $STAMP"

# 1) Database: consistent logical dump (InnoDB single-transaction, no table locks)
DB_FILE="$BACKUP_DIR/db_${STAMP}.sql.gz"
docker exec "$DB_CONTAINER" sh -c \
  'exec mariadb-dump -uroot -p"$MARIADB_ROOT_PASSWORD" --single-transaction --routines --all-databases' \
  | gzip > "$DB_FILE"

# Sanity check: archive must be valid and non-trivial
gzip -t "$DB_FILE"
[[ $(stat -c %s "$DB_FILE") -gt 1024 ]] || { log "ERROR: dump suspiciously small"; exit 1; }
log "DB dump OK: $DB_FILE ($(du -h "$DB_FILE" | cut -f1))"

# 2) WordPress files (uploads, plugins, themes) from the named volume
WP_FILE="$BACKUP_DIR/wp_${STAMP}.tar.gz"
docker run --rm -v "${WP_VOLUME}":/data:ro -v "$BACKUP_DIR":/backup alpine:3 \
  tar czf "/backup/wp_${STAMP}.tar.gz" -C /data .
log "Files backup OK: $WP_FILE ($(du -h "$WP_FILE" | cut -f1))"

# 3) Retention: delete backups older than RETENTION_DAYS
find "$BACKUP_DIR" -maxdepth 1 -type f \( -name 'db_*.sql.gz' -o -name 'wp_*.tar.gz' \) \
  -mtime +"$RETENTION_DAYS" -print -delete | while read -r f; do log "Pruned $f"; done

log "DONE backup $STAMP"
