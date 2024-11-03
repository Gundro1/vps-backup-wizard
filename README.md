# VPS Smart Backup Tool 🔄

![GitHub](https://img.shields.io/github/license/Gundro1/vps-smart-backup)
![Bash](https://img.shields.io/badge/Shell-Bash-green.svg)
![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)

A smart discovery and backup tool for VPS (Virtual Private Server) that automatically identifies and 
backs up all important projects, configurations, and system files without prior knowledge of the server structure.

## 🚀 Quick Start
bash
Clone the repository
git clone https://github.com/Gundro1/vps-smart-backup.git
Make script executable
cd vps-smart-backup
chmod +x discover_and_backup.sh
Run backup
./discover_and_backup.sh


## ✨ Features

- 🔍 Automatic project discovery
- 📁 Smart directory identification
- ⚙️ System configuration backup
- 📊 Process and port monitoring
- 📝 System information reporting
- 🗜️ Compressed backup creation

## 📦 What Gets Backed Up

### 1. Project Directories
- All non-system directories in home
- Hidden project directories
- Custom application folders

### 2. Configuration Files
- System service files
- Environment files
- Docker configurations
- Project configs

### 3. System Information
- Running processes
- Active ports
- System resources
- Service status

### 4. Project Files
- package.json
- config files
- .env files
- docker-compose files

## 📂 Backup Structure
plaintext
backup_YYYYMMDD_HHMM/
├── system_configs/
│ └── .service
├── project_files/
│ ├── package.json
│ ├── .config.js
│ └── .env
├── running_processes.txt
├── active_ports.txt
├── system_info.txt
└── vps_backup_YYYYMMDD_HHMM.tar.gz


## 🔄 Recovery
bash
Extract backup
tar -xzf vps_backup_YYYYMMDD_HHMM.tar.gz
Review contents
ls -la
Restore specific files
cp -r project_files/ ~/
cp -r system_configs/ /etc/systemd/system/


## 🤝 Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License
MIT License

## 👨‍💻 Author
GUNDRO

## 🙏 Acknowledgments
- Inspired by VPS management best practices
- Built for the open-source community

## ⭐ Support
If you find this tool helpful, please give it a ⭐️ on GitHub!
