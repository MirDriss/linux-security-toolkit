#!/bin/bash

DIR_SCRIPT="$(cd "$(dirname "$0")" && pwd)"
DIRECTORY="reports"
export REPORT_FILE="$DIRECTORY/audit_$(date -I).txt"
if [ ! -d "$DIRECTORY" ]; then
        mkdir "$DIRECTORY"
fi

RUN_USERS=false
RUN_SERVICES=false
RUN_PORTS=false

if [ "$#" -eq 0 ]; then 
        RUN_USERS=true
        RUN_SERVICES=true 
        RUN_PORTS=true
fi 

while [[ "$#" -gt 0 ]]
do 
	case "$1" in 
	--ports)
		RUN_PORTS=true
		shift
		;;
	--users)
		RUN_USERS=true
		shift
		;;
	--services)
		RUN_SERVICES=true
		shift
		;; 
	--help)
		echo "Usage: sudo ./security_audit.sh [--users] [--ports] [--services]"
            	exit 0
            	;;
	*)
		echo "Option not recongnize : $1"
		exit 1
		;;
	esac
done
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
if [ "$RUN_USERS" = true ]; then 


	log_level INFO "--- Users audit ---"  
	"$DIR_SCRIPT"/audits/users_uid0.sh 
	echo -e "\n" | tee -a "$REPORT_FILE"
fi
if [ "$RUN_PORTS" = true ]; then 
	log_level INFO "--- Open ports audit ---" 
	"$DIR_SCRIPT"/audits/ports_open.sh
	echo -e "\n" | tee -a "$REPORT_FILE"
fi
if [ "$RUN_SERVICES" = true ]; then 
	log_level INFO "--- Running services audit ---"
	"$DIR_SCRIPT"/audits/services_running.sh 
	echo -e "\n" | tee -a "$REPORT_FILE"
fi

