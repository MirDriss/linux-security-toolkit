#!/bin/bash 

echo "===== LINUX SECURITY AUDIT ====="

hostname=$(whoami)

echo "hostname: $hostname"
echo "Date: $(date)"
echo -e "\n"
echo "--- Users audit ---"
./audits/users_uid0.sh 
echo -e "\n"
echo "--- Open ports audit ---"
./audits/ports_open.sh
echo -e "\n"
echo "--- Running services audit ---"
./audits/services_running.sh
