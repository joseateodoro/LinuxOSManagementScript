#!/bin/bash

# file_system_monitor_tool.sh
# Monitor disk usage and manage files.

# -----------------------------
# 1) Display disk usage
# -----------------------------
show_disk_usage() {
    echo "=== Disk usage for each mounted filesystem ==="
    df -h
}

# -----------------------------
# 2) Top 15 largest files
# -----------------------------
top_largest_files() {
    read -p "Enter directory to scan: " dir
    if [ ! -d "$dir" ]; then
        echo "Directory does not exist."
        return
    fi

    echo "=== Top 15 largest files in $dir ==="
    # List only files, sorted by size, largest last, then take last 15
    find "$dir" -type f -printf "%s\t%p\n" 2>/dev/null \
        | sort -n \
        | tail -n 15 \
        | awk '{ size=$1; path=$2;
                 hum[1024**4]="T"; hum[1024**3]="G"; hum[1024**2]="M"; hum[1024]="K";
                 for (x=1024**4; x>=1024; x/=1024) {
                     if (size>=x) { printf "%.1f%s\t%s\n", size/x, hum[x], path; break }
                 }
                 if (size<1024) printf "%sB\t%s\n", size, path;
               }'
}

# -----------------------------
# 3) Files modified in 24 hours
# -----------------------------
recent_files() {
    read -p "Enter directory to search: " dir
    if [ ! -d "$dir" ]; then
        echo "Directory does not exist."
        return
    fi

    echo "=== Files modified in the last 24 hours in $dir ==="
    find "$dir" -type f -mtime -1 -printf "%TY-%Tm-%Td %TT  %p\n" 2>/dev/null
}

# -----------------------------
# 4) Clean temp files by size
# -----------------------------
clean_temp_files() {
    read -p "Enter directory containing temporary files (e.g., /tmp): " dir
    if [ ! -d "$dir" ]; then
        echo "Directory does not exist."
        return
    fi

    read -p "Delete files larger than how many MB? " size_mb

    echo "The following files larger than ${size_mb}M will be deleted in $dir:"
    find "$dir" -type f -size +"${size_mb}"M -print 2>/dev/null

    read -p "Proceed with deletion? (y/n): " ans
    if [[ "$ans" == "y" || "$ans" == "Y" ]]; then
        find "$dir" -type f -size +"${size_mb}"M -delete 2>/dev/null
        echo "Cleanup complete."
    else
        echo "Cleanup cancelled."
    fi
}

# -----------------------------
# Menu
# -----------------------------
menu() {
    echo ""
    echo "====== File System Monitor Tool ======"
    echo "1. Display disk usage for each filesystem"
    echo "2. List top 15 largest files in a directory"
    echo "3. Show files modified within last 24 hours"
    echo "4. Clean temporary files over a given size"
    echo "5. Exit"
    echo "======================================"
}

while true; do
    menu
    read -p "Choose an option: " choice
    case "$choice" in
        1) show_disk_usage ;;
        2) top_largest_files ;;
        3) recent_files ;;
        4) clean_temp_files ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option, try again." ;;
    esac
done
