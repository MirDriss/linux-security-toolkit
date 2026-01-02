#!/bin/bash 

DIR_SCRIPT="$(cd "$(dirname "$0")" && pwd)"
echo "===== LINUX SECURITY AUDIT ====="
echo "hostname: $(hostname)"
echo "Date: $(date)"
echo -e "\n"
echo "--- Users audit ---"
"$DIR_SCRIPT"/audits/users_uid0.sh 
echo -e "\n"
echo "--- Open ports audit ---"
"$DIR_SCRIPT"/audits/ports_open.sh
echo -e "\n"
echo "--- Running services audit ---"
"$DIR_SCRIPT"/audits/services_running.sh



echo "$DIR_SCRIPT"
