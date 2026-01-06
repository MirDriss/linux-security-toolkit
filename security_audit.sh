#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
RESET="\033[0m"
DIR_SCRIPT="$(cd "$(dirname "$0")" && pwd)"

DIRECTORY="reports"

if [ ! -d "$DIRECTORY" ]; then
        mkdir "$DIRECTORY"
fi

REPORT_FILE="$DIRECTORY/audit_$(date -I).txt"

function log_level(){
        level="$1"
        message="$2"
        case "$level" in 
                INFO) color="$BLUE" ;;
                OK) color="$GREEN" ;;
                WARNING) color="$YELLOW" ;;
                ALERT|CRITICAL) color="$RED" ;;
                *) color="$RESET" ;;
        esac 
        # Write in the terminal 
        echo -e "${color}[$level] ${RESET}$message " 
        # Write in the file 
        echo "[$level] $message" >> "$REPORT_FILE"
}

log_level INFO "===== LINUX SECURITY AUDIT ====="
log_level INFO "Audit executed at $(date '+%Y-%m-%d %H:%M:%S') by $(hostname)" 
log_level INFO "------------------------"
log_level INFO "hostname: $(hostname)"
log_level INFO "Date: $(date)"
echo -e "\n" | tee -a "$REPORT_FILE"
log_level INFO "--- Users audit ---"  
"$DIR_SCRIPT"/audits/users_uid0.sh | tee -a "$REPORT_FILE"
echo -e "\n" | tee -a "$REPORT_FILE"
log_level INFO "--- Open ports audit ---" 
"$DIR_SCRIPT"/audits/ports_open.sh | tee -a "$REPORT_FILE"
echo -e "\n" | tee -a "$REPORT_FILE"
log_level INFO "--- Running services audit ---"
"$DIR_SCRIPT"/audits/services_running.sh | tee -a "$REPORT_FILE"



