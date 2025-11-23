#!/bin/bash

LOG_FILE="cpu_usage_log.txt"

# ----------------------------------------------------
# Function: Calculate current CPU usage from /proc/stat
# ----------------------------------------------------
get_cpu_usage() {
    # Read first CPU line
    cpu_line1=($(grep '^cpu ' /proc/stat))
    idle1=${cpu_line1[4]}
    total1=0
    for val in "${cpu_line1[@]:1}"; do
        total1=$((total1 + val))
    done

    sleep 1

    cpu_line2=($(grep '^cpu ' /proc/stat))
    idle2=${cpu_line2[4]}
    total2=0
    for val in "${cpu_line2[@]:1}"; do
        total2=$((total2 + val))
    done

    idle_diff=$((idle2 - idle1))
    total_diff=$((total2 - total1))

    cpu_usage=$((100 * (total_diff - idle_diff) / total_diff))
    echo "$cpu_usage"
}

# ----------------------------------------------------
# Display current CPU usage
# ----------------------------------------------------
show_current_cpu() {
    cpu=$(get_cpu_usage)
    echo "Current CPU Usage: $cpu%"
}

# ----------------------------------------------------
# Track CPU usage over a period
# ----------------------------------------------------
track_cpu_usage() {
    read -p "Enter duration in seconds: " duration
    echo "Tracking CPU usage for $duration seconds..."
    end=$((SECONDS + duration))

    while [ $SECONDS -lt $end ]; do
        cpu=$(get_cpu_usage)
        echo "$(date): ${cpu}%" | tee -a $LOG_FILE
    done

    echo "Tracking completed. Data saved to $LOG_FILE"
}

# ----------------------------------------------------
# Set CPU affinity
# ----------------------------------------------------
set_cpu_affinity() {
    read -p "Enter PID: " pid
    read -p "Enter CPU cores (e.g., 0,1): " cores

    if taskset -cp "$cores" "$pid" >/dev/null 2>&1; then
        echo "CPU affinity set: PID $pid → CPUs $cores"
    else
        echo "Failed to set CPU affinity. Check PID."
    fi
}

# ----------------------------------------------------
# CPU alert threshold
# ----------------------------------------------------
cpu_alert() {
    read -p "Enter CPU threshold (e.g., 90): " threshold
    echo "Monitoring CPU usage... alert at > $threshold%"

    while true; do
        cpu=$(get_cpu_usage)
        echo "CPU: $cpu%"

        if [ "$cpu" -gt "$threshold" ]; then
            echo "***** ALERT: CPU usage exceeded threshold ($cpu%) *****"
            printf '\a'   # terminal bell
        fi
        sleep 1
    done
}

# ----------------------------------------------------
# Menu Function
# ----------------------------------------------------
menu() {
    echo ""
    echo "========== CPU Manager Tool =========="
    echo "1. Display current CPU usage"
    echo "2. Track CPU usage over time and log it"
    echo "3. Set CPU affinity for a process"
    echo "4. Generate alert if CPU exceeds threshold"
    echo "5. Exit"
    echo "======================================"
    echo ""
}

# ----------------------------------------------------
# Main Loop
# ----------------------------------------------------
while true; do
    menu
    read -p "Choose an option: " choice

    case $choice in
        1) show_current_cpu ;;
        2) track_cpu_usage ;;
        3) set_cpu_affinity ;;
        4) cpu_alert ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option!" ;;
    esac
done
