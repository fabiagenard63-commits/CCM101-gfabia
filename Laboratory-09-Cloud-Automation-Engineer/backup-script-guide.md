# **Script, Backup Guide**

### Full backup.sh script
```
#!/bin/bash 
# Automated Backup Script for CloudNova Technologies 
SOURCE_DIR="app-data" 
BACKUP_DIR="backups" 
TIMESTAMP=$(date +"%Y%m%d_%H%M%S") 
echo "Initiating automated backup..." 
# Create the backup directory if it does not exist 
mkdir -p $BACKUP_DIR 
# Compress the source directory into a tarball (.tar.gz) 
tar -czf $BACKUP_DIR/backup_$TIMESTAMP.tar.gz $SOURCE_DIR 
echo "Backup completed successfully at $TIMESTAMP!"
```

### chmod +x command
`chmod +x` command is used to give a file permission to be executed.

### cron expression used

| Field | Value | Meaning |
|---|---|---|
| Minute (0-59) | `0` | At minute 0, the start of the hour |
| Hour (0-23) | `2` | At 2 AM (24-hour clock) |
| Day of month (1-31) | `*` | Every day of the month |
| Month (1-12) | `*` | Every month |
| Day of week (0-7) | `*` | Every day of the week (0 or 7 = Sunday) |
| Command | `/root/backup.sh` | The script to run |
