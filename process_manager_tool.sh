#!/bin/bash

LOG_FILE="process_logs.txt"

list_processes() {
    echo "Listing all running processes..."
    ps aux --sort=-%cpu | awk '{printf "%-10s %-10s %-10s %-10s %s\n", $2, $1, $3, $4, $11}'
}

kill_process() {
    read -p "Enter PID to kill: " pid
    if kill "$pid" 2>/dev/null; then
        echo "Process $pid terminated."
    else
        echo "Failed to terminate process $pid."
    fi
}

processes_by_user() {
    read -p "Enter username: " user
    echo "Processes for user: $user"
    ps aux | grep "^$user"
}

top_processes() {
    echo "Top 5 CPU/Memory consuming processes:"
    ps aux --sort=-%cpu | head -n 6
}

schedule_checks() {
    echo "Scheduling process checks every minute..."
    while true; do
        echo "----- $(date) -----" >> "$LOG_FILE"
        ps aux --sort=-%cpu | head -n 10 >> "$LOG_FILE"
        echo "" >> "$LOG_FILE"
        sleep 60
    done
}

menu() {
    echo ""
    echo "========== Process Manager Tool =========="
    echo "1. List all running processes"
    echo "2. Kill a process by PID"
    echo "3. Display processes by user"
    echo "4. Show top 5 CPU/Memory consuming processes"
    echo "5. Start scheduled logging every minute"
    echo "6. Exit"
    echo "=========================================="
    echo ""
}

while true; do
    menu
    read -p "Choose an option: " choice
    case $choice in
        1) list_processes ;;
        2) kill_process ;;
        3) processes_by_user ;;
        4) top_processes ;;
        5) schedule_checks ;;
        6) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option. Try again." ;;
    esac
done
