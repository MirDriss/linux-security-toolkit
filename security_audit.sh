#!/bin/bash 

DIR_SCRIPT="$(cd "$(dirname "$0")" && pwd)"

DIRECTORY="reports"

if [ ! -d "$DIRECTORY" ]; then
        mkdir "$DIRECTORY"
fi

REPORT_FILE="$DIRECTORY/audit_$(date -I).txt"
echo "===== LINUX SECURITY AUDIT ====" >> "$REPORT_FILE"
echo "Audit executed at $(date '+%Y-%m-%d %H:%M:%S') by $(hostname)" >> "$REPORT_FILE"
echo "------------------------" >> "$REPORT_FILE"
echo "===== LINUX SECURITY AUDIT ====="
echo "hostname: $(hostname)"
echo "Date: $(date)"
echo -e "\n"
echo "--- Users audit ---" | tee -a "$REPORT_FILE" 
"$DIR_SCRIPT"/audits/users_uid0.sh | tee -a "$REPORT_FILE"
echo -e "\n" | tee -a "$REPORT_FILE"
echo "--- Open ports audit ---" | tee -a "$REPORT_FILE"
"$DIR_SCRIPT"/audits/ports_open.sh | tee -a "$REPORT_FILE"
echo -e "\n" | tee -a "$REPORT_FILE"
echo "--- Running services audit ---" | tee -a "$REPORT_FILE"
"$DIR_SCRIPT"/audits/services_running.sh | tee -a "$REPORT_FILE"


