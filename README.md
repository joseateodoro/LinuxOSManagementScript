# System Monitoring & Management Tools (Linux Bash Scripts)

A collection of four Bash-based system administration tools designed to monitor and manage **processes, CPU usage, filesystem activity, and network activity** on Linux systems.  
These scripts provide interactive menus, logging, automation, and real-time system insights.

---

## Authors

- [Jose Antonio Teodoro](https://github.com/joseateodoro)
- [Nick O'Brien]
- [Muhammad Khan]

---

## 📂 Included Tools

| Script Name                     | Purpose |
|---------------------------------|---------|
| `process_manager_tool.sh`       | Manage running processes and analyze CPU/memory load. |
| `cpu_manager_tool.sh`           | Monitor CPU usage, set affinity, track trends, and generate alerts. |
| `memory_manager_tool.sh`        | Manage Memory and Clearing Memory Cache
| `file_system_monitor_tool.sh`   | Inspect disk usage, find largest files, monitor recent changes, clean temp files. |
| `network_monitor_tool.sh`       | Analyze network traffic, display interfaces, track bandwidth, and detect connections. |

---

## Script Command List

| `process_manager_tool.sh`             | Purpose |
|---------------------------------------|---------|
| 1. Display Current CPU Usage          | Display CPU Usage and Collects from /proc/stat |
| 2. Track CPU Usage and Log            | Log and Track CPU Usage from /proc/stat |
| 3. Set CPU Affinity for Process       | Displays PIDs for CPU cores used
| 4. Alert if CPU Threshold Exceeds     | Checks CPU Thresh Is Exceeded Depending on User Input
| 5. Exit                               | Analyze network traffic, display interfaces, track bandwidth, and detect conn>

| `cpu_manager_tool.sh`             | Purpose |
|-----------------------------------|---------|
| 1. Display Current CPU Usage      | Display CPU Usage and Collects from /proc/stat |
| 2. Track CPU Usage and Log        | Log and Track CPU Usage from /proc/stat |
| 3. Set CPU Affinity for Process   | Displays PIDs for CPU cores used
| 4. Alert if CPU Threshold Exceeds | Checks CPU Thresh Is Exceeded Depending on User Input
| 5. Exit                           | Analyze network traffic, display interfaces, track bandwidth, and detect connec>

---

## 🚀 Installation

Clone or Download The Scripts:

```bash
git clone https://github.com/joseateodoro/LinuxOSManagementScript.git
cd OSProject
