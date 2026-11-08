#!/usr/bin/env bash
# Restore a database dump created by backup_db.sh.
# Usage: ./scripts/restore_db.sh /var/backups/enterprise-infra/db_YYYYmmdd_HHMMSS.sql.gz
set -euo pipefail

FILE="${1:-}"
DB_CONTAINER="${DB_CONTAINER:-ent_db}"

[[ -f "$FILE" ]] || { echo "Usage: $0 <db_backup.sql.gz>" >&2; exit 1; }
gzip -t "$FILE"

read -r -p "This OVERWRITES current databases. Type 'yes' to continue: " ok
[[ "$ok" == "yes" ]] || { echo "Aborted."; exit 1; }

gunzip -c "$FILE" | docker exec -i "$DB_CONTAINER" sh -c \
  'exec mariadb -uroot -p"$MARIADB_ROOT_PASSWORD"'

echo "Restore complete."
