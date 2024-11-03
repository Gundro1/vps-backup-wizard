#!/bin/bash
# discover_and_backup.sh

# Set backup directory
BACKUP_DIR=~/backups/$(date +%Y%m%d_%H%M)
mkdir -p $BACKUP_DIR
cd $BACKUP_DIR

echo "Starting Smart Discovery Backup..."

# Function to discover and backup user directories
discover_and_backup() {
    echo "Discovering projects and directories..."
    
    # Find all non-system directories in home
    echo "Scanning home directory..."
    find ~ -maxdepth 1 -type d ! -name ".*" ! -name "snap" ! -name "backup*" -exec tar -czf {}_backup.tar.gz {} \; 2>/dev/null

    # Find hidden project directories (excluding system ones)
    echo "Scanning hidden directories..."
    find ~ -maxdepth 1 -type d -name ".*" ! -name ".cache" ! -name ".local" ! -name ".mozilla" \
        ! -name ".ssh" ! -name ".npm" ! -name ".gnupg" -exec tar -czf {}_backup.tar.gz {} \; 2>/dev/null

    # Find all service files
    echo "Scanning for service files..."
    mkdir -p system_configs
    find /etc/systemd/system/ -type f -name "*.service" -exec cp {} system_configs/ \; 2>/dev/null
}

# Function to discover running processes
discover_processes() {
    echo "Discovering running processes..."
    ps aux | grep -i "node\|server\|api\|prover" > running_processes.txt
}

# Function to discover listening ports
discover_ports() {
    echo "Discovering active ports..."
    netstat -tulpn > active_ports.txt
}

# Function to discover project files
discover_project_files() {
    echo "Discovering project files..."
    
    # Find common project files
    find ~ -maxdepth 3 -type f \( \
        -name "package.json" -o \
        -name "*.config.js" -o \
        -name "*.service" -o \
        -name ".env*" -o \
        -name "docker-compose*.yml" \
    \) -exec cp --parents {} $BACKUP_DIR/project_files/ \; 2>/dev/null
}

# Main backup process
echo "=== Starting Discovery and Backup Process ==="
date

# Create necessary directories
mkdir -p {system_configs,project_files}

# Run discovery functions
discover_and_backup
discover_processes
discover_ports
discover_project_files

# Create system info report
echo "Creating system info report..."
{
    echo "=== System Information ==="
    date
    echo -e "\n=== Disk Usage ==="
    df -h
    echo -e "\n=== Memory Usage ==="
    free -h
    echo -e "\n=== Running Services ==="
    systemctl list-units --type=service --state=running
} > system_info.txt

# Create final archive
echo "Creating final backup archive..."
FINAL_BACKUP="vps_backup_$(date +%Y%m%d_%H%M).tar.gz"
tar -czf $FINAL_BACKUP *

# Calculate backup size
BACKUP_SIZE=$(du -h $FINAL_BACKUP | cut -f1)

echo "=== Backup Complete ==="
echo "Backup location: $BACKUP_DIR/$FINAL_BACKUP"
echo "Backup size: $BACKUP_SIZE"
echo "Date: $(date)"

# Show summary of discovered items
echo -e "\nDiscovered and backed up:"
echo "----------------------------------------"
find . -type f ! -name "*.tar.gz" | sed 's|^./||' | head -n 20
echo "... and more"
