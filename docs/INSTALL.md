# Installation Guide

# Create script
nano discover_and_backup.sh

# Make executable
chmod +x discover_and_backup.sh

# Run backup
./discover_and_backup.sh

# Download to local machine (run on your local machine)
scp root@YOUR_VPS_IP:~/backups/*/vps_backup_*.tar.gz ./
