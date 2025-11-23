#!/bin/bash

LOG_FILE="network_traffic_log.txt"

# ----------------------------------------------------
# 1. Display IP addresses + interface status
# ----------------------------------------------------
show_interfaces() {
    echo "=== Active Network Interfaces ==="
    ip -br addr show
}

# ----------------------------------------------------
# 2. Bandwidth usage for each interface (rx/tx bytes)
# ----------------------------------------------------
bandwidth_usage() {
    echo "=== Bandwidth Usage (RX/TX bytes) ==="
    for int in $(ls /sys/class/net); do
        rx=$(cat /sys/class/net/$int/statistics/rx_bytes)
        tx=$(cat /sys/class/net/$int/statistics/tx_bytes)
        echo "Interface: $int"
        echo "  RX: $rx bytes"
        echo "  TX: $tx bytes"
        echo ""
    done
}

# ----------------------------------------------------
# 3. Monitor connections + alert if a specific IP connects
# ----------------------------------------------------
monitor_ip_alert() {
    read -p "Enter IP address to watch for: " target_ip
    echo "Monitoring for connections from: $target_ip"
    echo "Press CTRL+C to stop."

    while true; do
        if ss -tn src "$target_ip" | grep "$target_ip" >/dev/null; then
            echo "***** ALERT: Connection detected from $target_ip *****"
            printf '\a'  # terminal beep
        fi
        sleep 2
    done
}

# ----------------------------------------------------
# 4. Track network traffic over time and log it
# ----------------------------------------------------
track_network_traffic() {
    read -p "Enter interface to monitor (e.g., eth0): " iface
    read -p "Enter monitoring duration (seconds): " duration

    if [ ! -d "/sys/class/net/$iface" ]; then
        echo "Interface not found!"
        return
    fi

    echo "Tracking network traffic on $iface for $duration seconds..."
    end=$((SECONDS + duration))

    while [ $SECONDS -lt $end ]; do
        rx=$(cat /sys/class/net/$iface/statistics/rx_bytes)
        tx=$(cat /sys/class/net/$iface/statistics/tx_bytes)

        echo "$(date): RX=${rx}B  TX=${tx}B" | tee -a "$LOG_FILE"
        sleep 1
    done

    echo "Network traffic tracking complete. Logged to $LOG_FILE"
}

# ----------------------------------------------------
# Menu
# ----------------------------------------------------
menu() {
    echo ""
    echo "======== Network Monitor Tool ========"
    echo "1. Display active interfaces and IPs"
    echo "2. Show bandwidth usage on interfaces"
    echo "3. Alert when a specific IP connects"
    echo "4. Track network traffic over time"
    echo "5. Exit"
    echo "======================================"
    echo ""
}

# ----------------------------------------------------
# Main loop
# ----------------------------------------------------
while true; do
    menu
    read -p "Choose an option: " choice

    case "$choice" in
        1) show_interfaces ;;
        2) bandwidth_usage ;;
        3) monitor_ip_alert ;;
        4) track_network_traffic ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option." ;;
    esac
done
