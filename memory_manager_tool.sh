#!/bin/bash

# ----------------------------------------------------
# Display Current Memory
# ----------------------------------------------------
show_current_memory() {
	echo "Memory Info"
	free -m
}

# ----------------------------------------------------
# List Processes Consuming More Than Specified Memory
# ----------------------------------------------------

list_process() {
	echo "Listing Processes Consuming More Than Specified Memory"
        echo "Apps Using Over 100MB"
        ps aux | awk '$6/1024 > 100 {print $1, $2, $4"%", $6}'
}

# ----------------------------------------------------
# Clear Cache: Clearing From /proc/sys/vm/drop_caches
# ----------------------------------------------------

clear_cache() {
	sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
	echo "Checking Memory..."
	echo "Clearing Cache..."
	available_mem=$(free -m | awk '/Mem: / {print $7}')
	if [ "$available_mem" -lt 100 ]; then
	echo "Low Memory! || Please Attend To Matter!"  
	else
	echo "Memory Is Sufficient!"
	fi
}

# ----------------------------------------------------
# Menu Function
# ----------------------------------------------------
menu() {
    echo ""
    echo "========== Memory Manager Tool =========="
    echo "1. Display Current Memory usage"
    echo "2. List Processes Consuming More Than Specified Memory"
    echo "3. Clear Cache and Memory Check"
    echo "4. Exit"
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
        1) show_current_memory ;;
        2) list_process ;;
        3) clear_cache ;;
        4) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option!" ;;
    esac
done

