#!/bin/bash

DIR_SCRIPT="$(cd "$(dirname "$0")" && pwd)"
DIRECTORY="reports"
export REPORT_FILE="$DIRECTORY/audit_$(date -I).txt"
if [ ! -d "$DIRECTORY" ]; then
        mkdir "$DIRECTORY"
fi

source "$DIR_SCRIPT"/audits/tools.sh
check_root
check_dependencies
echo -e "\n" | tee -a "$REPORT_FILE"
echo -e "================ LINUX SECURITY AUDIT ================ \n" | tee -a "$REPORT_FILE"
log_level INFO "Audit executed at $(date '+%Y-%m-%d %H:%M:%S') by $(hostname)" 
log_level INFO "------------------------"
log_level INFO "hostname: $(hostname)"
log_level INFO "Date: $(date)"
echo -e "\n" | tee -a "$REPORT_FILE"
log_level INFO "--- Users audit ---"  
"$DIR_SCRIPT"/audits/users_uid0.sh 
echo -e "\n" | tee -a "$REPORT_FILE"
log_level INFO "--- Open ports audit ---" 
"$DIR_SCRIPT"/audits/ports_open.sh 
echo -e "\n" | tee -a "$REPORT_FILE"
log_level INFO "--- Running services audit ---"
"$DIR_SCRIPT"/audits/services_running.sh 


