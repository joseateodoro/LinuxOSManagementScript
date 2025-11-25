# System Monitoring & Management Tools (Linux Bash Scripts)

A collection of four Bash-based system administration tools designed to monitor and manage **processes, CPU usage, filesystem activity, and network activity** on Linux systems.  
These scripts provide interactive menus, logging, automation, and real-time system insights.

---

## Authors

- [Jose Antonio Teodoro](https://github.com/joseateodoro)
- [Nick O'Brien](https://github.com/nrobez)
- [Muhammad Khan](https://github.com/khan642)

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

| `process_manager_tool.sh`             | Purpose                                                           |
|---------------------------------------|-------------------------------------------------------------------|
| 1. List Running Processes             | `ps aux` command runs |
| 2. Kill Process by PID                | Kills Process by PID from /dev/null |
| 3. Display User Processes             | `ps aux | grep` runs for selected user within system |
| 4. Show Top 5 CPU/Memory Consuming Processes | `ps aux` runs with `head -n 6` meaning the first 5 PIDs
| 5. Log Every Minute                   | Logs Processes by Date and inputs into logfile `process_logs.txt` |
| 6. Exit                               | Exit Program |

| `cpu_manager_tool.sh`             | Purpose                                                                 |
|-----------------------------------|-------------------------------------------------------------------------|
| 1. Display Current CPU Usage      | Display CPU Usage running `grep '^cpu '` and Collects from `/proc/stat` |
| 2. Track CPU Usage and Log        | Log and Track CPU Usage from `/proc/stat` into `cpu_usage_log.txt` |
| 3. Set CPU Affinity for Process   | Displays PIDs for CPU cores used
| 4. Alert if CPU Threshold Exceeds | Checks CPU Thresh Is Exceeded Depending on User Input
| 5. Exit                           | Exit Program

| `memory_manager_tool.sh`              | Purpose |
|---------------------------------------|-------------------------------------------------------------------------|
| 1. Display Memory Usage               | `free -m` command runs |
| 2. List Processes With Overconsumption of Memory | `ps aux | awk` runs and Displays Processes Using Too Much Memory |
| 3. Clear Cache and Memory Check       | `sync && echo 3 | sudo tee /proc/sys/vm/drop_caches` checks and clears memory cache |
| 6. Exit                               | Exit Program |

| `file_system_monitor_tool.sh`     | Purpose |
|-----------------------------------|---------|
| 1. Display Disk Usage For Each FileSystem       | `df -h` runs and shows system disk usage |
| 2. List Top 15 Largest files in Directory       | Starting from Root Directory, User Inputs a  Directory Path and Displays Top 15 Largest Files |
| 3. Show Modified Files Within the last 24 Hours | Shows Modified Files Within System |
| 4. Clean Temp Files over a given size           | Cleans Files With Given Size By User in MB |
| 5. Exit                                         | Exit Program

| `network_monitor_tool.sh`     | Purpose                                                                         |
|-----------------------------------|-----------------------------------------------------------------------------|
| 1. Display Active Interfaces and IPs            | `ip -br addr show` runs |
| 2. Display Bandwidth Usage On Interfaces        | Reads Bandwidth Usage From `/sys/class/net/$int/statistics/rx_bytes` & `/tx_bytes`|
| 3. Show Specific IP Connections                 | Shows Relation With Specified IPs by user. |
| 4. Track Network Traffic Overtime               | Tracking Traffic Data and Logging Into `network_traffic_log.txt`|
| 5. Exit                                         | Exit Program

---

## 🚀 Installation

Clone or Download The Scripts:

```bash
git clone https://github.com/joseateodoro/LinuxOSManagementScript.git
cd OSProject
